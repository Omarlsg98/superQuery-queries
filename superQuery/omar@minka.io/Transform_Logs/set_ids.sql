#CREATE TABLE minka-ach-dw.ach_tin_logs.stdout_ids AS
WITH logs AS
(SELECT 
       timestamp
        ,REGEXP_EXTRACT(textPayLoad,'([a-zA-Z]{17})') AS transfer_id
        ,REGEXP_EXTRACT(textPayLoad,'([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})') AS action_id
       ,textPayLoad
    FROM 
        minka-ach-dw.ach_tin_logs.stdout)
,transform AS
(SELECT
    timestamp
    ,IF(logs.transfer_id IS NULL, action.transfer_id,logs.transfer_id) as transfer_id
    ,logs.action_id
    ,textPayLoad
FROM 
    logs
LEFT JOIN 
    minka-ach-dw.ach_tin.action
        ON action.action_id=logs.action_id)
SELECT
    COUNT(transfer_id)
FROM
    transform
WHERE 
    transfer_id IS NULL
    AND action_id IS NOT NULL