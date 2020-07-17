SELECT
    tx_place
    ,COUNT(*)
FROM 
    minka-ach-dw.movii_bridge_log.movii_logs_transform
GROUP BY
    tx_place