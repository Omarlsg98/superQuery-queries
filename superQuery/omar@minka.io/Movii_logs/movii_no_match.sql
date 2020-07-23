SELECT 
    IF(m14.transfer_id IS NOT NULL, m14.transfer_id,m5.transfer_id) as transfer_id
    ,IF(MAX(m14.transfer_id) IS NOT NULL AND MAX(m5.transfer_id) IS NOT NULL 
        ,"14-07 | 05-07"
        ,IF(MAX(m14.transfer_id) IS NULL,"05-07","14-07") )AS reported_date
FROM 
    minka-ach-dw.movii_bridge_log.movii_diferencia_05_07_2020 AS m5
FULL JOIN 
     minka-ach-dw.movii_bridge_log.movii_diferencia_14_07_2020 AS m14 
        ON m14.transfer_id = m5.transfer_id 
GROUP BY
    transfer_id