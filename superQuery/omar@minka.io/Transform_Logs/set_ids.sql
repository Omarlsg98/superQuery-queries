CREATE OR REPLACE TABLE minka-ach-dw.ach_tin_logs.logs_transfer_ids AS 
(
WITH 
# REGEXP to extract the action_id and the transfer_id from stdout logs
logs AS
(SELECT 
       timestamp
        ,REGEXP_EXTRACT(payload,'\\b([0-9A-Za-z_]{17})\\b') AS transfer_id
        ,REGEXP_EXTRACT(payload,'([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})') AS action_id
       ,payload
    FROM 
        minka-ach-dw.ach_tin_logs.both_logs_deduplicated
    WHERE
        payload NOT LIKE "%sendActionWithIOU%"
    )
#Assign transfer_id according to action_id
,with_ids AS
(SELECT
    timestamp
    ,IF(action.transfer_id IS NULL, logs.transfer_id, action.transfer_id) AS transfer_id
    ,logs.action_id
    ,payload
FROM 
    logs
LEFT JOIN 
    minka-ach-dw.ach_tin.action
        ON action.action_id=logs.action_id)
SELECT *
FROM
with_ids
WHERE transfer_id IS NOT NULL)