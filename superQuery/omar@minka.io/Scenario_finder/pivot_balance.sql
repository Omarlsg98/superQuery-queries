SELECT 
    status
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
    ,IF(source.balance>=amount,TRUE,FALSE) AS balance_source
    ,IF(target.balance>=amount,TRUE,FALSE) AS balance_target
    ,count(*) as number_cases
    ,source_bank
    ,target_bank
    ,STRING_AGG(transfer_id) as cases
    ,STRING_AGG(CONCAT(source_wallet,"|",transfer_id,"|",target_wallet)) as wallets_transfer
FROM
    minka-ach-dw.temp.tx_n_actions
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS source ON source_signer=source.signer
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS target ON target_signer=target.signer
/*---WHERE---*/
/*WHERE
    status NOT IN ("PENDING","REJECTED","COMPLETED")
    AND created BETWEEN CAST(DATE_SUB(CURRENT_DATE("America/Bogota"),INTERVAL 1 DAY) AS STRING) AND  CAST(CURRENT_DATE("America/Bogota") AS STRING)
*/
WHERE 
    created>"2020-04-08"
    AND 
    (status NOT IN ("PENDING","REJECTED","COMPLETED")
    OR (status IN ("PENDING")
        AND CAST(SUBSTR(created,1,19) AS DATETIME) < DATETIME_SUB(CURRENT_DATETIME("America/Bogota"),INTERVAL 2 DAY)))
GROUP BY
    status
    ,upload_,main_action_,download_target_,reject_,download_source_,download_ambiguous_
    ,source_bank,target_bank
    ,balance_source,balance_target
ORDER BY
    number_cases DESC