/*---------------RESACT--------------------*/
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
    ,count(*) as number_cases
    ,source_bank
    ,target_bank
    ,ANY_VALUE(transfer_id)
FROM
    minka-ach-dw.temp.tx_n_actions
/*---WHERE---*/
WHERE 
   created BETWEEN "2020-07-08T23:00" AND "2020-07-09T17"
GROUP BY
    status, upload_,main_action_,download_target_,reject_,download_source_,download_ambiguous_,source_bank,target_bank
ORDER BY
    number_cases DESC