#CREATE TABLE minka-ach-dw.ach_tin_logs.stdout_ids AS
WITH logs AS
(SELECT 
       timestamp
        ,REGEXP_EXTRACT(textPayLoad,'\\b([0-9A-Za-z_]{17})\\b') AS transfer_id
        ,REGEXP_EXTRACT(textPayLoad,'([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})') AS action_id
       ,textPayLoad
    FROM 
        minka-ach-dw.ach_tin_logs.stdout
    WHERE
        textPayLoad NOT LIKE "%sendActionWithIOU%"
    )
,transform AS
(SELECT
    timestamp
    ,action.transfer_id AS transfer_id
    ,logs.action_id
    ,textPayLoad
FROM 
    logs
LEFT JOIN 
    minka-ach-dw.ach_tin.action
        ON action.action_id=logs.action_id)
SELECT
   transfer_id
   ,count(*) as n
FROM
    transform
WHERE
    textPayLoad NOT LIKE "%cron%"
GROUP BY
    transfer_id
ORDER BY 
    n DESC
LIMIT 1000