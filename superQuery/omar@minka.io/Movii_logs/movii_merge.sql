SELECT
    transfer_id
    ,COUNT(transfer_id) AS conteo
FROM
    movii_bridge_log.movii_logs_all
GROUP BY
    transfer_id
HAVING 
    conteo>1