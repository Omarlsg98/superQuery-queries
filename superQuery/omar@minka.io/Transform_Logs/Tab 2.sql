SELECT 
       "transform ids",MAX(timestamp)
FROM 
    minka-ach-dw.ach_tin_logs.stdout_transfer_ids
UNION
SELECT 
       "stdout",MAX(timestamp)
FROM 
    minka-ach-dw.ach_tin_logs.stdout