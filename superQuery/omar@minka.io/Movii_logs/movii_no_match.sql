WITH 
master_summary AS 
(
SELECT 
    transfer_id
   ,CASE
        WHEN fixed_by_minka!="pending" 
            THEN fixed_by_minka
        WHEN fixed_source_banks="no-data" OR fixed_target_banks="no-data"
            THEN "no-data"
        WHEN minka_analysis="solution-undefined"
            THEN "solution-undefined"
        WHEN created<"2020-07-09" AND updated>"2020-07-12" 
            THEN "failed-attempt"
        ELSE "master-pending"
   END AS master_status
FROM 
  minka-ach-dw.temp.master_data
),
daily_summary AS 
(
SELECT 
    transfer_id
   ,CONCAT(status,"-",to_do) AS daily_status
FROM 
  minka-ach-dw.ach_tin.manual_reverse
)
SELECT
    match.transfer_id
    ,IF(movii_transfer_id IS NULL, "","X") AS in_mahindra
    ,IF(action_transfer_id IS NULL, "","X") AS in_actions
    ,match.* EXCEPT(transfer_id,movii_transfer_id,action_transfer_id,source_channel,updated)
    ,CASE
        WHEN master_status IS NOT NULL THEN master_status
        WHEN daily_status IS NOT NULL THEN daily_status
        ELSE "not_available"
     END AS deeper_analysis
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
LEFT JOIN 
   daily_summary AS daily 
        ON LOWER(daily.transfer_id)=LOWER(match.transfer_id)
WHERE
    match.analisis NOT IN ("  target_OK"," source_OK target_OK"," source_OK"," target_OK","Update_movii_logs")
    AND created>"2020-01-01"
    AND (transfer.source_channel IS NULL 
        OR transfer.source_channel !='"MassTransferCLI"')