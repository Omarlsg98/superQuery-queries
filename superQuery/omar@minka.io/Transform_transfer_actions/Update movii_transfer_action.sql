SELECT 
    movii.transfer_id
  , SUBSTR(movii_transfer_id,1,2) AS movii_type
  ,* EXCEPT(transfer_id,amount, error_code, error_message)
  , transfer.amount AS amount
  , transfer.error_code AS transfer_error_code
  , transfer.error_message AS transfer_error_message
  , action.error_code AS action_error_code
  , action.error_message AS action_error_message
FROM
  minka-ach-dw.ach_tin.transfer
LEFT JOIN 
    `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09` AS movii ON UPPER(transfer.transfer_id)=movii.cell_id
LEFT JOIN   minka-ach-dw.ach_tin.action ON transfer.transfer_id = action.transfer_id
WHERE 
    transfer.transfer_id="9p6hhE32ZvakHTCHi"