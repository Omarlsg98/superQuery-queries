/*---------------RESACT--------------------*/
SELECT
    status
    ,(SELECT
        String_AGG(CONCAT(status," ",count.total), " || ")
    FROM 
        UNNEST(upload.status)) as upload_
    ,(SELECT
        String_AGG(CONCAT(status," ",count.total), " || ")
    FROM
        UNNEST(main_action.status)) as main_action_
    ,(SELECT 
        String_AGG(CONCAT(status," ",count.total), " || ") 
    FROM
        UNNEST(download_target.status)) as download_target_
    ,(SELECT 
        String_AGG(CONCAT(status," ",count.total), " || ") 
    FROM
        UNNEST(reject.status)) as reject_ 
    ,(SELECT 
        String_AGG(CONCAT(status," ",count.total), " || ") 
    FROM 
        UNNEST(download_source.status)) as download_source_
    ,(SELECT 
        String_AGG(CONCAT(status," ",count.total), " || ") 
    FROM 
        UNNEST(download_ambiguous.status)) as download_ambiguous_
    ,count(*) as number_cases
FROM
    ach-tin-prd.temp.tx_n_actions
/*---WHERE---*/
WHERE 
 transfer_id="t9BYrWs0VohxdvL77"
GROUP BY
    status, upload_,main_action_,download_target_,reject_,download_source_,download_ambiguous_
ORDER BY
    number_cases DESC