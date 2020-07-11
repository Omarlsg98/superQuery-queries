SELECT
   movii_transfer_id
    ,transfer.updated AS transfer_updated
FROM 
    minka-ach-dw.movii_bridge_log.movii_action_match_20_07_08 AS match
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer
     ON transfer.transfer_id=match.movii_transfer_id
WHERE
    match.match!=0