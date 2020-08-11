WITH 
master_summary AS 
(
SELECT 
    transfer_id
   ,IF(fixed_by_minka="pending"
        ,IF(fixed_source_banks="no-data" OR fixed_target_banks="no-data"
            ,"no-data"
            ,IF(minka_analysis="solution-undefined"
                ,"solution-undefined"
                ,"pending"
            )
        )
        ,fixed_by_minka) AS master_status
FROM 
  minka-ach-dw.temp.master_data
)
SELECT
    match.* EXCEPT(source_channel,updated)
    ,IFNULL(master_status,"not_available") AS deeper_analysis
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
FROM
    minka-ach-dw.temp.movii_match AS match
LEFT JOIN
    minka-ach-dw.ach_tin.transfiya_pivot_specific AS transfer
        ON transfer.transfer_id=match.transfer_id
LEFT JOIN 
   master_summary AS master 
        ON LOWER(master.transfer_id)=LOWER(match.transfer_id)
WHERE
    match.analisis NOT IN ("  target_OK"," source_OK target_OK"," source_OK"," target_OK","Update_movii_logs")
    AND created>"2020-01-01"
    AND (transfer.source_channel IS NULL 
        OR transfer.source_channel !='"MassTransferCLI"')