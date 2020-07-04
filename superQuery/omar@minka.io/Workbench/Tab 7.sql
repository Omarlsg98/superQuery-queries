SELECT
    tx_id
FROM 
    minka-ach-dw.movii_bridge_log.movii_status_200702 as movii
GROUP BY
     core_cat ,core_status