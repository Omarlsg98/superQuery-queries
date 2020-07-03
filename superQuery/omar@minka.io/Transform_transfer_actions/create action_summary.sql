/*ACTION SUMMARY*/
create table  minka-ach-dw.temp.action_summary as
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
    select action_transfer_id, type,action_status as status, error_code as code,error_code as message, count(*) as count,
    sum(IF(action_hash<> '"PENDING"',1,0)) as with_hash, sum(IF(action_hash='"PENDING"',1,0)) as without_hash,
    min(action_created) as created, null as updated
    From minka-ach-dw.temp.action_new_downloads
    group by action_transfer_id,type,action_status,error_code)as T1
  group by action_transfer_id,type,status) as T2
group by action_transfer_id, type