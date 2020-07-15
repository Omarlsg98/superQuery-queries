SELECT
   match.*
    ,transfer.updated AS transfer_updated
FROM 
    minka-ach-dw.movii_bridge_log.movii_action_match_20_07_08 AS match
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer
     ON transfer.transfer_id=match.movii_transfer_id
WHERE
   movii_transfer_id="knz9wGw0ttSnrN0us"