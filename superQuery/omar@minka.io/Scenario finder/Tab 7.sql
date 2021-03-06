SELECT
   transfer_id
   ,type AS transfer_type
   ,status AS transfer_status
   ,error.code AS transfer_error_code
   ,error.message AS transfer_error_message
   ,main_action.status[offset(0)].status AS main_action_status
   ,main_action.status[offset(0)].count.with_hash AS main_action_count
   ,upload.status[offset(0)].status AS upload_status
   ,upload.status[offset(0)].count.with_hash AS upload_count
   ,download_source.status[offset(0)].status AS download_source_status
   ,download_source.status[offset(0)].count.with_hash AS download_source_count_signed
   ,tx_id
   ,tx_labels_id
   ,source
   ,source_wallet
   ,source_signer
   ,source_bank
   ,target
   ,target_wallet
   ,target_signer
   ,target_bank
   ,amount
   ,created
   ,updated
   ,source_channel
FROM
    ach-tin-prd.temp.tx_n_actions as t
WHERE
    upload.count is null 
    AND  main_action.count=1 
    AND  download_target.count is null 
    AND  download_source.count is null
    AND reject.count is null 
    AND download_ambiguous.count is null
    AND type!="REQUEST"
    AND created>"2020-04-01"
    AND source_channel!='"MassTransferCLI"'