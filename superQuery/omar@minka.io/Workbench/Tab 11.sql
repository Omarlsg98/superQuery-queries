SELECT 
    #SUBSTR(TRANSFER_ID,1,2) AS type
    MIN(TRANSFER_ON),
    MAX(TRANSFER_ON)
FROM
    `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09`