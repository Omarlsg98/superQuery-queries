WITH 
diferencia AS 
(
SELECT 
    IF(m14.transfer_id IS NOT NULL, LOWER(m14.transfer_id),LOWER(m5.transfer_id)) as transfer_id
    ,IF(MAX(m14.transfer_id) IS NOT NULL AND MAX(m5.transfer_id) IS NOT NULL 
        ,"05-07 | 14-07"
        ,IF(MAX(m14.transfer_id) IS NULL,"05-07","14-07") )AS reported_date
FROM 
    minka-ach-dw.movii_bridge_log.movii_diferencia_05_07_2020 AS m5
FULL JOIN 
     minka-ach-dw.movii_bridge_log.movii_diferencia_14_07_2020 AS m14 
        ON LOWER(m14.transfer_id) = LOWER(m5.transfer_id)
GROUP BY
    transfer_id
)
SELECT
    match.* EXCEPT(source_channel,updated)
    ,transfer_type
    ,upload_
    ,main_action_
    ,download_target_
    ,reject_
    ,download_source_
    ,download_ambiguous_
    ,amount
    ,transfer.created AS transfer_created
    ,transfer.updated AS transfer_updated
    ,transfer.source_channel
    ,source_wallet
    ,target_wallet
    ,IFNULL(diferencia.reported_date,"false") AS in_diferencia
FROM
    minka-ach-dw.temp.movii_match AS match
LEFT JOIN
    minka-ach-dw.ach_tin.transfiya_pivot_specific AS transfer
        ON transfer.transfer_id=match.transfer_id
LEFT JOIN 
   diferencia ON UPPER(diferencia.transfer_id)=UPPER(match.transfer_id)
WHERE
    (match.analisis NOT IN ("  target_OK"," source_OK target_OK"," source_OK"," target_OK","Update_movii_logs")
    AND created>"2020-01-01")
    OR diferencia.transfer_id IS NOT NULL /*Show all tx reported*/