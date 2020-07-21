/*CREATE TABLE minka-ach-dw.ach_tin_logs.both_logs AS (
SELECT 
   timestamp
   ,jsonPayload.message as textPayLoad
FROM 
    ach-tin-prd.achtin_logs.winston_log
UNION ALL
SELECT 
   timestamp
   ,textPayLoad
FROM 
    ach-tin-prd.achtin_logs.stdout
)
*/
SELECT
    timestamp
    ,textPayLoad
    ,COUNT(*) AS N
FROM
    minka-ach-dw.ach_tin_logs.both_logs
GROUP BY 
    timestamp,textPayLoad
HAVING
    N>1