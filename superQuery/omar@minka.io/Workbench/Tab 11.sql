SELECT 
    #SUBSTR(TRANSFER_ID,1,2) AS type
    MIN(CAST(TRANSFER_ON AS STRING))
    ,MAX(CAST(TRANSFER_ON AS STRING))
FROM
    `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09`