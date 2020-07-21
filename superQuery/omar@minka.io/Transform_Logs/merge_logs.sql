CREATE OR REPLACE TABLE minka-ach-dw.ach_tin_logs.both_logs AS (
/*
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
)*/
    SELECT 
        k.timestamp
        ,k.textPayLoad AS text_pay_load
    FROM (
      SELECT ARRAY_AGG(row LIMIT 1)[OFFSET(0)] k 
      FROM 
        `minka-ach-dw.ach_tin_logs.both_logs` row
      GROUP BY 
        timestamp,textPayLoad
    )
)