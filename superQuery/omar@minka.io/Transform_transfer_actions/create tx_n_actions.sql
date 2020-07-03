/*TX N ACTIONS*/ 
create table minka-ach-dw.temp.tx_n_actions as
select * EXCEPT(error_code,error_message), STRUCT(error_code as code,error_message as message) as error,
  (select STRUCT(created, updated, count, status) 
  from minka-ach-dw.temp.action_summary asum
  where t.transfer_id=asum.action_transfer_id and (asum.type="SEND" or asum.type="REQUEST")) as main_action,
  (select STRUCT(created, updated, count, status) 
  from minka-ach-dw.temp.action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="UPLOAD") as upload,
  (select STRUCT(created, updated, count, status) 
  from minka-ach-dw.temp.action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="DOWNLOAD_TARGET") as download_target,
  (select STRUCT(created, updated, count, status) 
  from minka-ach-dw.temp.action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="REJECT") as reject,
  (select STRUCT(created, updated, count, status) 
  from minka-ach-dw.temp.action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="DOWNLOAD_SOURCE") as download_source,
  (select STRUCT(created, updated, count, status) 
  from minka-ach-dw.temp.action_summary asum
  where t.transfer_id=asum.action_transfer_id and asum.type="DOWNLOAD_AMBIGUOUS") as download_ambiguous
from ach-tin-prd.sql_dump.transfer t