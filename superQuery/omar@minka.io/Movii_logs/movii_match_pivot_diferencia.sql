SELECT
   match.* EXCEPT(source_bank,target_bank)
   ,transfer_type
   ,match.source_bank	
   ,match.target_bank
   ,upload_
   ,main_action_
   ,download_target_
   ,reject_
   ,download_source_
   ,download_ambiguous_
   ,amount
   ,transfer.created AS transfer_created
   ,transfer.updated AS transfer_updated
   ,source_channel
   ,source_wallet
   ,target_wallet
FROM 
    minka-ach-dw.temp.movii_match AS match
LEFT JOIN 
    minka-ach-dw.ach_tin.transfiya_pivot_specific AS transfer
     ON transfer.transfer_id=match.movii_transfer_id
WHERE
    UPPER(movii_transfer_id) IN (
        SELECT transfer_id
        FROM minka-ach-dw.movii_bridge_log.movii_diferencia_05_07_2020)
    OR movii_transfer_id IN (
        SELECT transfer_id
        FROM minka-ach-dw.movii_bridge_log.movii_diferencia_05_07_2020)