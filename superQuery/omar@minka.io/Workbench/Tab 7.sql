SELECT
    SUBSTR(tx_id,1,2) as tx_inicio
    ,COUNT(*)
FROM 
    minka-ach-dw.movii_bridge_log.movii_status_200702 as movii
GROUP BY
    tx_inicio