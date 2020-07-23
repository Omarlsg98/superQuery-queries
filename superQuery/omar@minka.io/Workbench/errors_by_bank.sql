SELECT
   transfer_id 
   ,CASE
        WHEN upload.count IS NULL 
            THEN STRUCT ("debit" AS endpoint, source_bank AS bank) #error_debit
        WHEN  EXISTS (SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("ERROR")) 
            THEN NULL #ignore_main_action
        WHEN 1 > (SELECT SUM(count.with_hash) FROM UNNEST(main_action.status)) #no_hay_hash
                OR EXISTS (SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("ERROR"))
            THEN STRUCT ("action" AS endpoint, source_bank AS bank) #error_action
        WHEN download_target.count IS NULL 
            THEN STRUCT ("credit" AS endpoint, target_bank AS bank) #error_credit_target
        WHEN EXISTS (SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR"))
            THEN NULL #ignore_main_action
        WHEN EXISTS (SELECT 1 FROM UNNEST(reject.status) WHERE status IN ("ERROR"))
            THEN NULL #ignore_main_action
        WHEN download_source.count IS NULL AND EXISTS (SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("REJECTED"))
            THEN STRUCT ("credit" AS endpoint, source_bank AS bank) #error_credit_source
        WHEN  EXISTS (SELECT 1 FROM UNNEST(download_source.status) WHERE status IN ("ERROR"))
            THEN NULL #ignore_main_action
        ELSE 
           STRUCT ("action" AS endpoint, source_bank AS bank) #error_action
   END
   AS analysis
FROM
    minka-ach-dw.temp.tx_n_actions as t
WHERE
    created BETWEEN "2020-04-08" AND "2020-07-21"
    AND source_channel!='"MassTransferCLI"'
ORDER BY 
    transfer_id DESC
LIMIT 10000