/*---------------RESACT--------------------*/
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
    ,source_bank
    ,target_bank
    ,created
    ,updated
    ,source_wallet
    ,target_wallet
    ,amount
    ,source_channel
FROM
    minka-ach-dw.temp.tx_n_actions
/*---WHERE---*/