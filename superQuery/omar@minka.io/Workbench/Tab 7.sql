SELECT
    SUBSTR(tx_id,1,3) as tx_inicio
FROM 
    minka-ach-dw.movii_bridge_log.movii_status_200702 as movii
GROUP BY
    tx_inicio