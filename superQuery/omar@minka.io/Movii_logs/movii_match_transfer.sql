SELECT
   match.*
   ,transfer.status
   ,source_bank	
   ,target_bank	
   ,amount
   ,transfer.created AS transfer_created
   ,transfer.updated AS transfer_updated
   ,source_channel
   ,source_wallet
   ,target_wallet
FROM 
    minka-ach-dw.movii_bridge_log.movii_match_20_07_08 AS match
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer
     ON transfer.transfer_id=match.movii_transfer_id
WHERE
    transfer.created>"2020-04-01"
    AND transfer.updated<"2020-07-09T13"
    AND match.match!=0