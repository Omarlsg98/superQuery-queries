SELECT 
  * EXCEPT(transfer_id, amount, error_code, error_message)
  , transfer.transfer_id as transfer
  , transfer.amount AS amount
  , transfer.error_code AS transfer_error_code
  , transfer.error_message AS transfer_error_message
  , action.error_code AS action_error_code
  , action.error_message AS action_error_message
FROM
    `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09_gc` AS movii
LEFT JOIN   minka-ach-dw.ach_tin.transfer ON UPPER(transfer.transfer_id)=movii.transfer_id
LEFT JOIN   minka-ach-dw.ach_tin.action ON movii.transfer_id = UPPER(action.transfer_id)
LIMIT 10