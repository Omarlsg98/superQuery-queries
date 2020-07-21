CREATE OR REPLACE TABLE minka-ach-dw.ach_tin_logs.both_logs_deduplicated AS (
WITH
#Merge winston and stdout logs
both_logs AS (
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
#deduplicate logs and save
SELECT 
    k.timestamp
    ,k.textPayLoad AS payload
FROM (
  SELECT ARRAY_AGG(row LIMIT 1)[OFFSET(0)] k 
  FROM 
    both_logs AS  row
  GROUP BY 
    TIMESTAMP_TRUNC(timestamp,SECOND),textPayLoad
)
)