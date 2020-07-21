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
SELECT
    MAX(timestamp)
FROM
 logs