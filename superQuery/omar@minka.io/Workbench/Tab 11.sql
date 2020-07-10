SELECT 
    SUBSTR(TRANSFER_ID,1,3) AS type
    , COUNT(CELL_ID)
FROM
    `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09`
GROUP BY
    type