create table minka-ach-dw.temp.tx_n_actions as(
/*ACTION NEW DOWNLOADS*/
WITH action_new_downloads as (
  select
    *
  EXCEPT
    (action_type),
    action_type as type
  from
   minka-ach-dw.ach_tin.action
  where
    action_type not in ("ISSUE", "TOPUP", "WITHDRAW", "DOWNLOAD")
  UNION ALL
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
     minka-ach-dw.ach_tin.action act
    Inner join (
      select
        transfer_id as txId,
        source_signer as tx_sourceSigner,
        target_signer as tx_targetSigner
      from
        minka-ach-dw.ach_tin.transfer
    ) as tx ON tx.txId = act.action_transfer_id
  where
    act.action_type in ("DOWNLOAD")
)
#Action summary
,action_summary as (
    select action_transfer_id, min(created) as created, max(updated) as updated , type, sum(count) as count ,ARRAY_AGG(whole_status) as status
    from(
     select action_transfer_id, type,sum(count) as count,
     STRUCT(
          status,
          STRUCT(sum(count) as total,sum(with_hash) as with_hash,sum(without_hash)as without_hash) as count,
          max(updated)as updated,
          ARRAY_AGG(STRUCT(code,message,STRUCT(count as total,with_hash,without_hash) as count))as error
        )as whole_status,
     min(created) as created, max(updated) as updated
     FROM(
        select action_transfer_id, type,action_status as status, error_code as code,error_message as message, count(*) as count,
        sum(IF(action_hash<> 'PENDING',1,0)) as with_hash, sum(IF(action_hash='PENDING',1,0)) as without_hash,
        min(action_created) as created, max(action_udpated) as updated
        From action_new_downloads
        group by action_transfer_id,type,action_status,error_code,error_message)as T1
      group by action_transfer_id,type,status) as T2
    group by action_transfer_id, type
)
/*TX N ACTIONS*/
select * EXCEPT(error_code,error_message), STRUCT(error_code as code,error_message as message) as error,
  (select STRUCT(created, updated, count, status) 
  from action_summary asum
  where t.transfer_id=asum.action_transfer_id and (asum.type="SEND" or asum.type="REQUEST")) as main_action,
  (select STRUCT(created, updated, count, status) 
  from action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="UPLOAD") as upload,
  (select STRUCT(created, updated, count, status) 
  from action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="DOWNLOAD_TARGET") as download_target,
  (select STRUCT(created, updated, count, status) 
  from action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="REJECT") as reject,
  (select STRUCT(created, updated, count, status) 
  from action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="DOWNLOAD_SOURCE") as download_source,
  (select STRUCT(created, updated, count, status) 
  from action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="DOWNLOAD_AMBIGUOUS") as download_ambiguous
from minka-ach-dw.ach_tin.transfer t
)