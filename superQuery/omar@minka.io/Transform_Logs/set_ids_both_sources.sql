CREATE TABLE minka-ach-dw.ach_tin_logs.both_logs AS (
SELECT 
   timestamp
   ,jsonPayload.message as textPayLoad
FROM 
    ach-tin-prd.achtin_logs.winston_log
WHERE
    jsonPayload.message NOT LIKE "%sendActionWithIOU%"
UNION ALL
SELECT 
   timestamp
   ,textPayLoad
FROM 
    ach-tin-prd.achtin_logs.stdout
WHERE
    textPayLoad NOT LIKE "%sendActionWithIOU%"
)