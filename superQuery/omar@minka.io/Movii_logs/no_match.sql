SELECT
    no_match.*
    ,transfer.status AS transfer_status
FROM 
    minka-ach-dw.movii_bridge_log.movii_action_no_match_20_07_08 AS no_match
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer
     ON transfer.transfer_id=no_match.movii_transfer_id