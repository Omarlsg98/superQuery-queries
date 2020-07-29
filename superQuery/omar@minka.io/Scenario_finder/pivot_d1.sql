SELECT
    FARM_FINGERPRINT(ARRAY_TO_STRING([transfer_status, upload_,main_action_,download_target_,reject_,download_source_,download_ambiguous_,source_bank,target_bank], '')) AS scenery_key
    ,*
FROM
    minka-ach-dw.ach_tin.transfiya_pivot_specific
WHERE 
        (
        transfer_status NOT IN ("PENDING","REJECTED","COMPLETED")
           AND created>"2020-07-08"
        )
    OR 
        (transfer_status IN ("PENDING")
            AND CAST(SUBSTR(created,1,19) AS DATETIME) < DATETIME_SUB(CURRENT_DATETIME("America/Bogota"),INTERVAL 30 HOUR))
ORDER BY
    scenery_key DESC