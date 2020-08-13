CREATE OR REPLACE TABLE minka-ach-dw.temp.tx_n_actions as(
/*ACTION NEW DOWNLOADS*/
WITH action_new_downloads as (
  SELECT
    * EXCEPT (action_type),
    action_type AS type,
    action_type AS original_type
  FROM
    minka-ach-dw.ach_tin.action
  WHERE
    action_type NOT IN ("ISSUE", "TOPUP", "WITHDRAW", "DOWNLOAD")
  UNION ALL
  SELECT
    *  EXCEPT (
          action_type,
          txId,
          tx_sourceSigner,
          tx_targetSigner
    ),
    CASE
        WHEN tx_sourceSigner = tx_targetSigner
            THEN"DOWNLOAD_AMBIGUOUS"
        WHEN act.action_source = tx_targetSigner
            THEN "DOWNLOAD_TARGET"
        WHEN act.action_source = tx_sourceSigner
            THEN "DOWNLOAD_SOURCE"
        ELSE
            "DOWNLOAD_AMBIGUOUS"
    END AS type
    ,act.action_type AS original_type
  FROM
    minka-ach-dw.ach_tin.action act
    INNER JOIN (
      SELECT
        transfer_id AS txId,
        source_signer AS tx_sourceSigner,
        target_signer AS tx_targetSigner
      FROM
        minka-ach-dw.ach_tin.transfer
    ) AS tx ON tx.txId = act.transfer_id
  WHERE
    act.action_type IN ("DOWNLOAD")
)
#Pre-step-1 for action_summary
,grouped_by_error AS
(
    SELECT
      transfer_id,
      type,
      action_status AS status,
      error_code AS code,
      error_message AS message,
      COUNT(*) AS count,
      SUM(IF(action_hash <> 'PENDING', 1, 0)) AS with_hash,
      SUM(IF(action_hash = 'PENDING', 1, 0)) AS without_hash,
      MIN(action_created) AS created,
      MAX(action_udpated) AS updated
    FROM
      action_new_downloads
    GROUP BY
      transfer_id,type,action_status, error_code, error_message
)
#Pre-step-2 for action_summary
,grouped_by_status AS
(
    SELECT
      transfer_id,
      type,
      SUM(count) AS count,
      SUM(with_hash) AS with_hash,
      STRUCT(
        status,
        STRUCT(
          SUM(count) AS total,
          SUM(with_hash) AS with_hash,
          SUM(without_hash) AS without_hash
        ) AS count,
        MAX(updated) AS updated,
        ARRAY_AGG(
          STRUCT(
            code,
            message,
            STRUCT(
                count AS total,
                with_hash,
                without_hash
            ) AS count
          )
        ) AS error
      ) AS whole_status,
      MIN(created) AS created,
      MAX(updated) AS updated
    FROM
        grouped_by_error
    GROUP BY
      transfer_id,type,status
)
#Action summary
,action_summary as (
    SELECT
      transfer_id,
      MIN(created) AS created,
      MAX(updated) AS updated,
      type,
      SUM(count) AS count,
      SUM(with_hash) AS with_hash,
      ARRAY_AGG(whole_status) AS status
    FROM
        grouped_by_status
    GROUP BY
      transfer_id, type
)
/*TX N ACTIONS*/
 SELECT
      * EXCEPT(error_code, error_message),
      STRUCT(error_code AS code, error_message AS message) AS error,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND (
            asum.type = "SEND"
            or asum.type = "REQUEST"
          )
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS main_action,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "UPLOAD"
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS upload,
       IFNULL((
        SELECT
         STRUCT(created, updated, count, with_hash, status)
        FROM
          action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "DOWNLOAD_TARGET"
      ) ,STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS download_target,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "REJECT"
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS reject,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "DOWNLOAD_SOURCE"
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS download_source,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "DOWNLOAD_AMBIGUOUS"
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS download_ambiguous 
    FROM
      minka-ach-dw.ach_tin.transfer t
)