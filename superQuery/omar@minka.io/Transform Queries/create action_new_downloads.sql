/*ACTION NEW DOWNLOADS*/
create table ach-tin-prd.temp.action_new_downloads as (
  select
    *
  EXCEPT
    (type),
    type
  from
    ach-tin-prd.sql_dump.action
  where
    type not in ("ISSUE", "TOPUP", "WITHDRAW", "DOWNLOAD")
  UNION
    DISTINCT
  select
    *
  EXCEPT
    (type, txId, tx_sourceSigner, tx_targetSigner),
    IF(
      tx_sourceSigner = tx_targetSigner,
      "DOWNLOAD_AMBIGUOUS",
      IF(
        act.sourceSigner = tx_targetSigner,
        "DOWNLOAD_TARGET",
        IF(
          act.sourceSigner = tx_sourceSigner,
          "DOWNLOAD_SOURCE",
          "DOWNLOAD_AMBIGUOUS"
        )
      )
    ) as type
  from
    ach-tin-prd.sql_dump.action act
    Inner join (
      select
        transfer_id as txId,
        source_signer as tx_sourceSigner,
        target_signer as tx_targetSigner
      from
        ach-tin-prd.sql_dump.transfer
    ) as tx ON tx.txId = act.transferId
  where
    act.type in ("DOWNLOAD")
)