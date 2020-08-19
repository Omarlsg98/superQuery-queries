#Check duplicates
SELECT
    transfer_id
    ,COUNT(transfer_id) AS conteo
FROM
    movii_bridge_log.movii_logs_all
GROUP BY
    transfer_id
HAVING 
    conteo>1;


#Check max dates of the movii_logs
SELECT
    MAX(transfer_on) as MAX, "logs_all"
FROM 
    minka-ach-dw.movii_bridge_log.movii_logs_all
UNION ALL
SELECT
    MAX(created) as MAX , "transform"
FROM 
    minka-ach-dw.movii_bridge_log.movii_logs_transform;
    
    