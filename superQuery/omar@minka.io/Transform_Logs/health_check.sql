SELECT 
       "transform ids",MAX(timestamp)
FROM 
    minka-ach-dw.ach_tin_logs.logs_transfer_ids
UNION ALL
SELECT 
       "stdout",MAX(timestamp)
FROM 
    ach-tin-prd.achtin_logs.winston_log