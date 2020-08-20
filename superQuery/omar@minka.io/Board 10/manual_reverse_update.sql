SELECT
    * EXCEPT(suggested_to_do,reported_on,updated_on,comments)
    ,"" AS suggested_to_do
    ,CAST(reported_on AS STRING) AS reported_on
    ,CAST(updated_on As STRING) AS updated_on
    ,comments
FROM
    minka-ach-dw.ach_tin.manual_reverse
UNION ALL
    SELECT
        transfer_type
        ,transfer_status
        ,upload_	
        ,main_action_	
        ,download_target_	
        ,reject_	
        ,download_source_	
        ,download_ambiguous_	
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
        ,CAST(FARM_FINGERPRINT(ARRAY_TO_STRING([transfer_status, upload_,main_action_,download_target_,reject_,download_source_,download_ambiguous_,source_bank,target_bank,CONCAT(source_has_balance,target_has_balance)], '')) AS STRING) AS scenery_key
        ,transfer_id
        ,"pending" AS status	
        ,"not_defined" AS to_do
        ,fix_action AS suggested_to_do
        ,CAST(CURRENT_DATETIME("America/Bogota")  AS STRING) AS  reported_on
        ,CAST(CURRENT_DATETIME("America/Bogota")  AS STRING) AS  updated_on	
        ,"" AS comments
    FROM
        minka-ach-dw.ach_tin.pivot_specific
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
ORDER BY 
    reported_on ASC