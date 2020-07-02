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
    ,source_bank
    ,target_bank
    ,STRING_AGG(transfer_id)
FROM
    ach-tin-prd.temp.tx_n_actions
/*---WHERE---*/
WHERE
    upload.count is null 
    AND  main_action.count=1 
    AND  download_target.count is null 
    AND  download_source.count is null
    AND reject.count is null 
    AND download_ambiguous.count is null
    AND created BETWEEN "2020-04-01" AND "2020-06-30"
    AND source_channel!='"MassTransferCLI"'
    AND status="ERROR"
GROUP BY
    status, upload_,main_action_,download_target_,reject_,download_source_,download_ambiguous_,source_bank,target_bank
ORDER BY
    number_cases DESC