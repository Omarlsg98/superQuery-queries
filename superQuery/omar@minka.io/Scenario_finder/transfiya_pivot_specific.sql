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
    ,source_wallet
    ,target_wallet
    ,amount
FROM
    minka-ach-dw.temp.tx_n_actions
/*---WHERE---*/
WHERE 
   status NOT IN ("PENDING","REJECTED","COMPLETED")
   OR (status IN ("PENDING") 
        AND CAST(SUBSTR(created,1,19) AS DATETIME) < DATETIME_SUB(CURRENT_DATETIME("America/Bogota"),INTERVAL 1 DAY))