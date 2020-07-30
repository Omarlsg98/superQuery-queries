SELECT
    FARM_FINGERPRINT(ARRAY_TO_STRING([transfer_status, upload_,main_action_,download_target_,reject_,download_source_,download_ambiguous_,source_bank,target_bank,CONCAT(source_has_balance,target_has_balance)], '')) AS scenery_key
    ,transfer_status
    ,upload_
    ,main_action_
    ,download_target_
    ,reject_ 
    ,download_source_
    ,download_ambiguous_
    ,source_has_balance
    ,target_has_balance
    ,count(transfer_id) AS number_cases
    ,source_bank
    ,target_bank
    ,STRING_AGG(transfer_id) AS cases
FROM
    minka-ach-dw.ach_tin.transfiya_pivot_specific
WHERE 
   (
        (
        transfer_status NOT IN ("PENDING","REJECTED","COMPLETED")
           AND created>"2020-07-08"
        )
        OR 
        (transfer_status IN ("PENDING")
            AND CAST(SUBSTR(created,1,19) AS DATETIME) < DATETIME_SUB(CURRENT_DATETIME("America/Bogota"),INTERVAL 30 HOUR))
    )
    AND 
        transfer_id NOT IN (
            SELECT transfer_id 
            FROM minka-ach-dw.ach_tin.manual_reverse)
GROUP BY
    transfer_status, upload_,main_action_,download_target_,reject_,download_source_,download_ambiguous_,source_bank,target_bank,source_has_balance,target_has_balance
ORDER BY
    number_cases DESC