select transferId, min(created) as created, max(updated) as updated , type, sum(count) as count ,ARRAY_AGG(whole_status) as status
from(
 select transferId, type,sum(count) as count,
 STRUCT(
      status,
      STRUCT(sum(count) as total,sum(with_hash) as with_hash,sum(without_hash)as without_hash) as count,
      max(updated)as updated,
      ARRAY_AGG(STRUCT(code,message,STRUCT(count as total,with_hash,without_hash) as count))as error
    )as whole_status,
 min(created) as created, max(updated) as updated
 FROM(
    select transferId, type,status,JSON_EXTRACT(error,'$.code') as code,JSON_EXTRACT(error,'$.message') as message, count(*) as count,
    sum(IF(JSON_EXTRACT(labels,"$.hash")<> '"PENDING"',1,0)) as with_hash, sum(IF(JSON_EXTRACT(labels,"$.hash")='"PENDING"',1,0)) as without_hash,
    min(created) as created, max(updated) as updated
    From temp.action_new_downloads
    group by transferId,type,status,error)as T1
  group by transferId,type,status) as T2
group by transferId, type