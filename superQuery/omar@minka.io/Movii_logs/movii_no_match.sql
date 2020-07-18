WITH 
diferencia AS 
(
SELECT 
    transfer_id
FROM 
    minka-ach-dw.movii_bridge_log.movii_diferencia_05_07_2020
GROUP BY
    transfer_id
)
SELECT
    match.* EXCEPT(source_channel)
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
    ,(diferencia.transfer_id IS NOT NULL) AS in_diferencia
FROM
    minka-ach-dw.temp.movii_match AS match
LEFT JOIN
    minka-ach-dw.ach_tin.transfiya_pivot_specific AS transfer
        ON transfer.transfer_id=match.movii_transfer_id
LEFT JOIN 
    diferencia ON diferencia.transfer_id=match.movii_transfer_id
WHERE
    match.analisis NOT IN ("  target_OK"," source_OK target_OK"," source_OK"," target_OK")