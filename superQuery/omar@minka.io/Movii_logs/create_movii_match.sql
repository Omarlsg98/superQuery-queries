CREATE OR REPLACE TABLE  minka-ach-dw.temp.movii_match AS
(WITH
#create new mahindra types
#Concat the place of the movement and the type of the movement
movii_types AS  
(    SELECT 
        CONCAT(tx_place,"_",service_type) AS type
        ,movii.transfer_id
        ,movii.amount
    FROM
        minka-ach-dw.movii_bridge_log.movii_logs_transform AS movii
    WHERE 
        transfer_status="TS"
)
#summarize the mahindra movements by transfer_id, dividing movements to source of momvents to target
,movii_balance AS 
(
SELECT 
    transfer_id
    , COUNTIF(type="SOURCE_CASHIN") AS ci_source
    , COUNTIF(type="SOURCE_MERCHPAY") AS co_source
    , COUNTIF(type="TARGET_CASHIN") AS ci_target
    , COUNTIF(type="TARGET_MERCHPAY") AS co_target
    , SUM(IF(type="SOURCE_CASHIN" OR type="TARGET_CASHIN" ,CAST(amount AS FLOAT64),-CAST(amount AS FLOAT64))) AS movii_balance
FROM
    movii_types
GROUP BY
    transfer_id
)
#add the transfers that are from movii but dont have any mahindra movement (not in movii_logs)
,all_movii_balance AS  
(    SELECT 
        IFNULL(movii.transfer_id,transfer.transfer_id) AS transfer_id
        ,movii.transfer_id AS movii_transfer_id
        ,IFNULL(movii.ci_source,0) AS ci_source
        ,IFNULL(movii.co_source,0) AS co_source
        ,IFNULL(movii.ci_target,0) AS ci_target
        ,IFNULL(movii.co_target,0) AS co_target
        ,IFNULL(movii_balance,0) AS movii_balance
        ,transfer.status
        ,transfer.source_bank
        ,transfer.target_bank
        ,transfer.source_channel
        ,transfer.updated
    FROM
       movii_balance AS movii
    FULL JOIN 
         minka-ach-dw.ach_tin.transfer ON transfer.transfer_id=movii.transfer_id 
    WHERE
        movii.transfer_id IS NOT NULL
        OR 
        (
            (transfer.source_bank="Movii" OR transfer.target_bank="Movii")
            AND created>"2020-01-01" #minimum date available of movii_logs
        )
)
#summarize the action movements done by movii by transfer_id, dividing movements to source of momvents to target
, action_balance AS 
(
SELECT 
    transfer_id
    , COUNTIF(type="DOWNLOAD_SOURCE" OR type="DOWNLOAD_AMBIGUOUS") AS dw_source
    , COUNTIF(type="DOWNLOAD_TARGET") AS dw_target
    , COUNTIF(type="UPLOAD") AS up_source
    , SUM(IF(type IN ("DOWNLOAD_SOURCE","DOWNLOAD_TARGET","DOWNLOAD_AMBIGUOUS"),
            -CAST(action_amount AS FLOAT64),CAST(action_amount AS FLOAT64))) AS action_balance
FROM
    minka-ach-dw.temp.action_new_downloads
WHERE
    type IN ("DOWNLOAD_SOURCE","DOWNLOAD_TARGET","DOWNLOAD_AMBIGUOUS", "UPLOAD")
    AND action_hash NOT IN ("PENDING")
    AND (action_source_signer="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2" 
        OR action_target_signer="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2")
GROUP BY
    transfer_id
)
#join the movements in the cloud with the movements in mahindra
,movii_actions AS 
(
SELECT 
    movii.transfer_id AS transfer_id
    ,movii_transfer_id
    ,action.transfer_id AS action_transfer_id
    ,movii.status AS transfer_status
    ,source_bank
    ,target_bank
    ,ci_source
    ,co_source
    ,(ci_source-co_source) AS cico_source_balance
    ,ci_target
    ,co_target
    ,(ci_target-co_target) AS cico_target_balance
    ,(ci_source+ci_target-co_source-co_target) AS cico_total_balance
    ,movii_balance
    ,IFNULL(dw_source,0) AS dw_source
    ,IFNULL(up_source,0) AS up_source
    ,IFNULL((dw_source-up_source),0) AS dwup_source_balance
    ,IFNULL(dw_target,0) AS dw_target
    ,IFNULL((dw_source+dw_target-up_source),0) AS dwup_total_balance
    ,IFNULL(action_balance,0) AS transfiya_balance
    ,source_channel
    ,updated
FROM
    all_movii_balance AS movii
LEFT JOIN
    action_balance AS action
        ON action.transfer_id= movii.transfer_id
)
#calculate the overall balance (movii/cloud) by place (source/target)
, match_table AS (
SELECT
  * 
  ,(cico_source_balance-dwup_source_balance) AS match_source
  ,(cico_target_balance-dw_target) AS match_target
  ,(movii_balance + transfiya_balance) AS match
FROM
    movii_actions
)
#Analize the results
#put a classification (an action to do) according to the balance, status, and place of the bank
#have a failsafe for outdated movii_logs
SELECT
    *
    ,IF(updated>"2020-08-11","Update_movii_logs"
        ,CONCAT(
            IF (transfer_status IN ("COMPLETED")
                ,CONCAT(
                IF(source_bank="Movii"
                    ,CASE
                        WHEN cico_source_balance=-1 AND dwup_source_balance=-1 THEN " source_OK"
                        WHEN cico_source_balance!=-1 AND dwup_source_balance=-1 THEN CONCAT(" ",ABS(match_source),IF(match_source<0,"_cashin","_cashout"),"_source")
                        WHEN cico_source_balance=-1 AND dwup_source_balance=0 THEN " Sign_UPLOAD_no_Mahindra"
                        WHEN cico_source_balance=0 AND dwup_source_balance=0 AND source_channel!='"MassTransferCLI"' THEN " make_UPLOAD"
                        WHEN cico_source_balance=0 AND dwup_source_balance=0 AND source_channel='"MassTransferCLI"' THEN " source_OK"
                        ELSE " DANGER_source_completed"
                    END,""),
                IF(target_bank="Movii"
                    ,CASE
                        WHEN cico_target_balance=1 AND dw_target=1 THEN " target_OK"
                        WHEN cico_target_balance!=1 AND dw_target=1 THEN CONCAT(" ",ABS(match_target),IF(match_target<0,"_cashin","_cashout"),"_target")
                        WHEN cico_target_balance=1 AND dw_target=0 THEN " Sign_DOWNLOAD_TARGET_no_Mahindra"
                        WHEN cico_target_balance=0 AND dw_target=0 THEN " make_DOWNLOAD_TARGET"
                        ELSE " DANGER_target_completed"
                    END,"")
                    )
                ,"")
            ,IF (transfer_status IN ("REJECTED")
                ,CONCAT(
                IF(source_bank="Movii"
                    ,CASE
                        WHEN cico_source_balance=0 AND dwup_source_balance=0 THEN " source_OK"
                        WHEN cico_source_balance!=0 AND dwup_source_balance=0 THEN CONCAT(" ",ABS(match_source),IF(match_source<0,"_cashin","_cashout"),"_source")
                        WHEN cico_source_balance=0 AND dwup_source_balance=-1 THEN " Sign_DOWNLOAD_SOURCE_no_Mahindra"
                        WHEN cico_source_balance=-1 AND dwup_source_balance=-1 THEN " make_DOWNLOAD_SOURCE"
                        ELSE " DANGER_source_rejected"
                    END,""),
                IF(target_bank="Movii"
                    ,CASE
                        WHEN cico_target_balance=0 AND dw_target=0 THEN " target_OK"
                        WHEN cico_target_balance!=0 AND dw_target=0 THEN CONCAT(" ",ABS(match_target),IF(match_target<0,"_cashin","_cashout"),"_target")
                        WHEN cico_target_balance=0 AND dw_target!=0 THEN " REJECTED_CLOUD_REVIEW"
                        ELSE " DANGER_target_rejected"
                    END,"")
                    )
                ,"")
            ,IF (transfer_status IN ("ERROR","ACCEPTED","INITIATED","PENDING")
                ,CONCAT(
                    IF(match_source=0 AND match_target=0
                        ," both_OK"
                        ,CONCAT(   
                            IF(source_bank="Movii"
                                ,CASE
                                    WHEN match_source<0 THEN CONCAT(" ",-match_source,"_cashin_source")
                                    WHEN match_source=0 THEN " source_OK"
                                    WHEN match_source>0 THEN " source_not_move"
                                END
                                ,IF(match_source!=0," DANGER_isnot_sourcebank","")
                            )
                            ,IF(target_bank="Movii"
                                ,CASE
                                    WHEN match_target<0 THEN CONCAT(" ",-match_target,"_cashin_target")
                                    WHEN match_target=0 THEN " target_OK"
                                    WHEN match_target>0 THEN " target_not_move"
                                END
                                ,IF(match_target!=0," DANGER_isnot_targetbank","")
                            )
                        )
                    )
                    ," CLOUD_REVIEW"
                )
            ,"")
        )
    ) AS Analisis
FROM
    match_table
)