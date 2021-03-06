WITH 
# REGEXP to extract the action_id and the transfer_id from stdout logs
logs AS
(SELECT 
       timestamp
        ,REGEXP_EXTRACT(textPayLoad,'\\b([0-9A-Za-z_]{17})\\b') AS transfer_id
        ,REGEXP_EXTRACT(textPayLoad,'([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})') AS action_id
       ,textPayLoad
    FROM 
        ach-tin-prd.achtin_logs.stdout
    WHERE
        textPayLoad NOT LIKE "%sendActionWithIOU%"
    )
,transform AS
(SELECT
    timestamp
    ,IF(action.transfer_id IS NULL, logs.transfer_id, action.transfer_id) AS transfer_id
    ,logs.action_id
    ,textPayLoad
FROM 
    logs
LEFT JOIN 
    minka-ach-dw.ach_tin.action
        ON action.action_id=logs.action_id)
SELECT
    *
FROM 
    transform
WHERE timestamp>"2020-07-21"