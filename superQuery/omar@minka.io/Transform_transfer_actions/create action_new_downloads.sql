/*ACTION NEW DOWNLOADS*/
CREATE OR REPLACE TABLE minka-ach-dw.temp.action_new_downloads AS (
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