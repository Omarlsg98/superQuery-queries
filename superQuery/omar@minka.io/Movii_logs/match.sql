SELECT
    match.*
    ,transfer.status AS transfer_status
    ,transfer.source_bank AS source_bank
    ,transfer.target_bank AS target_bank
    ,transfer.created AS transfer_created
    ,transfer.source_channel AS source_channel
FROM 
    minka-ach-dw.movii_bridge_log.movii_action_no_match_20_07_08 AS match
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer
     ON transfer.transfer_id=match.movii_transfer_id