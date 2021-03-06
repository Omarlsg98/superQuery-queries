SELECT 
    transfer_id 
    ,type AS transfer_type
    ,status AS transfer_status
    ,(SELECT
        String_AGG(CONCAT(status," ",count.total, "/",count.with_hash), " || ")
    FROM 
        UNNEST(upload.status)) as upload_
    ,(SELECT
        String_AGG(CONCAT(status," ",count.total, "/",count.with_hash), " || ")
    FROM
        UNNEST(main_action.status)) as main_action_
    ,(SELECT  
        String_AGG(CONCAT(status," ",count.total, "/",count.with_hash), " || ")
    FROM
        UNNEST(download_target.status)) as download_target_
    ,(SELECT 
       String_AGG(CONCAT(status," ",count.total, "/",count.with_hash), " || ")
    FROM
        UNNEST(reject.status)) as reject_ 
    ,(SELECT 
        String_AGG(CONCAT(status," ",count.total, "/",count.with_hash), " || ")
    FROM 
        UNNEST(download_source.status)) as download_source_
    ,(SELECT 
       String_AGG(CONCAT(status," ",count.total, "/",count.with_hash), " || ")
    FROM 
        UNNEST(download_ambiguous.status)) as download_ambiguous_
    ,source_has_balance
    ,target_has_balance
    ,source_bank
    ,target_bank
    ,created
    ,updated
    ,source_wallet
    ,target_wallet
    ,amount
    ,source_balance
    ,target_balance
    ,source_signer
    ,target_signer
    ,source_channel
    ,error
    ,fix_action
    ,upload.with_hash AS uploads_signed
    ,main_action.with_hash AS main_actions_signed
    ,download_target.with_hash AS downs_target_signed
    ,reject.with_hash AS rejects_signed
    ,download_source.with_hash AS downs_source_signed
    ,download_ambiguous.with_hash AS downs_ambiguous_signed
FROM
    minka-ach-dw.temp.tx_n_actions