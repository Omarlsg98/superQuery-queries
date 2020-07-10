SELECT
    no_match.*
    ,transfer.type
FROM 
    minka-ach-dw.movii_bridge_log.movii_action_no_match_20_07_08 AS no_match
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer
     ON transfer.trasnsfer_id=no_match.transfer_id
LIMIT 10