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
    ,IF(source.balance>=amount,TRUE,FALSE) AS source_has_balance
    ,IF(target.balance>=amount,TRUE,FALSE) AS target_has_balance
    ,source_bank
    ,target_bank
    ,created
    ,updated
    ,source_wallet
    ,target_wallet
    ,amount
    ,source.balance AS source_balance
    ,target.balance AS target_balance
    ,source_signer
    ,target_signer
    ,source_channel
FROM
    minka-ach-dw.temp.tx_n_actions
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS source ON source_signer=source.signer
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS target ON target_signer=target.signer
WHERE
    transfer_id="GbwLMmuiLv2aNLgOG";
    AND created BETWEEN "2020-04-08" AND "2020-07-09"
    AND status NOT IN ("REJECTED","COMPLETED")
    AND (source_channel!='"MassTransferCLI"' OR source_channel IS NULL)