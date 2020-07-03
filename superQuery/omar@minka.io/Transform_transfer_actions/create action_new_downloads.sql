/*ACTION NEW DOWNLOADS*/
create table minka-ach-dw.temp.action_new_downloads as (
  select
    *
  EXCEPT
    (action_type),
    action_type as type
  from
   minka-ach-dw.ach_tin_20200702_1159.action
  where
    action_type not in ("ISSUE", "TOPUP", "WITHDRAW", "DOWNLOAD")
  UNION
    DISTINCT
  select
    *
  EXCEPT
    (action_type, txId, tx_sourceSigner, tx_targetSigner),
    IF(
      tx_sourceSigner = tx_targetSigner,
      "DOWNLOAD_AMBIGUOUS",
      IF(
        act.action_source = tx_targetSigner,
        "DOWNLOAD_TARGET",
        IF(
          act.action_source = tx_sourceSigner,
          "DOWNLOAD_SOURCE",
          "DOWNLOAD_AMBIGUOUS"
        )
      )
    ) as type
  from
     minka-ach-dw.ach_tin_20200702_1159.action act
    Inner join (
      select
        transfer_id as txId,
        source_signer as tx_sourceSigner,
        target_signer as tx_targetSigner
      from
        minka-ach-dw.ach_tin_20200702_1159.transfer
    ) as tx ON tx.txId = act.action_transfer_id
  where
    act.action_type in ("DOWNLOAD")
)