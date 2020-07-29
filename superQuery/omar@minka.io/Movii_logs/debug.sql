SELECT
    *
FROM 
    minka-ach-dw.temp.movii_match
WHERE
    movii_transfer_id IS NULL
LIMIT 1000;

SELECT 
    MIN(created)
FROM
     minka-ach-dw.movii_bridge_log.movii_logs_transform