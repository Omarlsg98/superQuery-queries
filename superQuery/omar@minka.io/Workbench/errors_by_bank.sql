WITH 
#map the main_action error 
main_action_analysis AS (
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
)
#assign the endpoint according to the action_type and the main_action_analysis
, endpoint_mapping AS (
SELECT
    IF(action_type IN ("SEND","REQUEST"),analysis.bank, action_source_bankrouter) AS bank
    ,CASE
        WHEN action_type="UPLOAD" THEN "debit"
        WHEN action_type="DOWNLOAD" THEN "credit"
        WHEN action_type IN ("SEND","REQUEST") THEN analysis.endpoint
        WHEN action_type ="REJECT" THEN "action"
    END AS endpoint_involved
    ,error_code
    ,error_message
    ,count(action.transfer_id) as number
FROM
    minka-ach-dw.ach_tin.action
INNER JOIN
    main_action_analysis ON main_action_analysis.transfer_id=action.transfer_id
WHERE
    action_source_bankrouter IS NOT NULL 
    AND (action_type!="REJECT" OR (action_type="REJECT" AND action_status="ERROR"))
    AND error_code NOT IN (0,123,301,302,331)
    AND error_code IS NOT NULL
GROUP BY
    error_code
    ,error_message
    ,bank
    ,endpoint_involved
)
#bank_mapping -> normalize bank_names 
SELECT
     CASE
        WHEN bank="Banco AV Villas" OR bank="$bancoavvillas"THEN "Av Villas"
    	WHEN bank="Banco Caja Social" OR bank="$bancocajasocial" THEN "Caja Social"
    	WHEN bank="DAVIPLATA" OR bank="$daviplataprd" THEN "Daviplata"
    	WHEN bank="DAVIVIENDA" OR bank="$daviviendaprd" THEN "Davivienda"
    	WHEN bank="NEQUI" OR bank="$nequi" THEN "Nequi"
    	WHEN bank="Movii" OR bank="$movii" THEN "Movii" 
    	WHEN bank="Banco Serfinanza" OR bank="$bancoserfinanza" THEN "Serfinanza"
    	WHEN bank="Banco Itau" OR bank="$itauproduccion" THEN "Itau"
    	WHEN bank LIKE "%coopcentral%" THEN "Coopcentral"
        ELSE bank
     END AS bank
    ,endpoint_involved
    ,error_code
    ,error_message
    ,SUM(number) as number
FROM
    endpoint_mapping
WHERE
    endpoint_involved IS NOT NULL
    AND bank IS NOT NULL
GROUP BY 
    error_code
    ,error_message
    ,bank
    ,endpoint_involved
ORDER BY
    bank ASC
    , number DESC