/*TX N ACTIONS*/ 
create table temp.tx_n_actions as
select * EXCEPT(error_code,error_message), STRUCT(error_code as code,error_message as message) as error,
  (select STRUCT(created, updated, count, status) 
  from temp.action_summary asum
  where t.transfer_id=asum.transferid and (asum.type="SEND" or asum.type="REQUEST")) as main_action,
  (select STRUCT(created, updated, count, status) 
  from temp.action_summary asum
  where t.transfer_id=asum.transferid and asum.type="UPLOAD") as upload,
  (select STRUCT(created, updated, count, status) 
  from temp.action_summary asum
  where t.transfer_id=asum.transferid and asum.type="DOWNLOAD_TARGET") as download_target,
  (select STRUCT(created, updated, count, status) 
  from temp.action_summary asum
  where t.transfer_id=asum.transferid and asum.type="REJECT") as reject,
  (select STRUCT(created, updated, count, status) 
  from temp.action_summary asum
  where t.transfer_id=asum.transferid and asum.type="DOWNLOAD_SOURCE") as download_source,
  (select STRUCT(created, updated, count, status) 
  from temp.action_summary asum
  where t.transfer_id=asum.transferid and asum.type="DOWNLOAD_AMBIGUOUS") as download_ambiguous
from sql_dump.transfer t