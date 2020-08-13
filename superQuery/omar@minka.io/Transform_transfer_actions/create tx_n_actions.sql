/*TX N ACTIONS*/
CREATE OR REPLACE TABLE minka-ach-dw.tests.tx_n_actions AS (
    SELECT
      * EXCEPT(error_code, error_message),
      STRUCT(error_code AS code, error_message AS message) AS error,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          minka-ach-dw.temp.action_summary asum
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
          minka-ach-dw.temp.action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "UPLOAD"
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS upload,
       IFNULL((
        SELECT
         STRUCT(created, updated, count, with_hash, status)
        FROM
          minka-ach-dw.temp.action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "DOWNLOAD_TARGET"
      ) ,STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS download_target,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          minka-ach-dw.temp.action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "REJECT"
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS reject,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          minka-ach-dw.temp.action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "DOWNLOAD_SOURCE"
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS download_source,
      IFNULL((
        SELECT
          STRUCT(created, updated, count,with_hash, status)
        FROM
          minka-ach-dw.temp.action_summary asum
        WHERE
          t.transfer_id = asum.transfer_id
          AND asum.type = "DOWNLOAD_AMBIGUOUS"
      ),STRUCT(NULL AS created, NULL AS updated, 0 AS count, 0 AS with_hash, NULL AS status))
      AS download_ambiguous 
    FROM
      minka-ach-dw.ach_tin.transfer t
    LIMIT 100
)