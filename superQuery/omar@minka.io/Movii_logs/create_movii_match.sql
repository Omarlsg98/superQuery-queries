CREATE TABLE  minka-ach-dw.temp.movii_match AS
(WITH 
movii_types AS 
(    SELECT 
        CONCAT(tx_place,"_",service_type) AS type
        ,transfer_id
        ,amount
        ,cloud_status
        ,source_bank
        ,target_bank
    FROM
        minka-ach-dw.movii_bridge_log.movii_logs_transform
    WHERE 
        transfer_status="TS"
)
,movii_balance AS 
(
SELECT 
    transfer_id
    ,MIN(cloud_status) AS status
    ,MIN(source_bank) AS source_bank
    ,MIN(target_bank) AS target_bank
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
,movii_actions AS 
(
SELECT 
    movii.transfer_id AS movii_transfer_id
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
FROM
    movii_balance AS movii
LEFT JOIN
    action_balance AS action
        ON action.transfer_id= movii.transfer_id
)
, match_table AS (
SELECT
  * 
  ,(cico_source_balance-dwup_source_balance) AS match_source
  ,(cico_target_balance-dw_target) AS match_target
  ,(movii_balance + transfiya_balance) AS match
FROM
    movii_actions
)
SELECT
    *
    ,CONCAT(
        IF (transfer_status IN ("COMPLETED")
            ,CONCAT(
            IF(source_bank="Movii"
                ,CASE
                    WHEN cico_source_balance=-1 AND dwup_source_balance=-1 THEN "OK"
                    WHEN cico_source_balance!=-1 AND dwup_source_balance=-1 THEN CONCAT(-cico_source_balance-1," cash_source")
                    WHEN cico_source_balance=-1 AND dwup_source_balance=0 THEN "Sign UPLOAD no Mahindra"
                    WHEN cico_source_balance=0 AND dwup_source_balance=0 THEN "make_UPLOAD"
                    WHEN cico_source_balance NOT IN (0,-1) AND dwup_source_balance  NOT IN (0,-1) THEN "DANGER"
                END,""),
            IF(target_bank="Movii"
                ,CASE
                    WHEN cico_target_balance=1 AND dw_target=1 THEN "OK"
                    WHEN cico_target_balance!=1 AND dw_target=1 THEN CONCAT(-cico_target_balance+1," cash_target")
                    WHEN cico_target_balance=1 AND dw_target=0 THEN "Sign DOWNLOAD_TARGET no Mahindra"
                    WHEN cico_target_balance=0 AND dw_target=0 THEN "make_DOWNLOAD_TARGET"
                    WHEN cico_target_balance NOT IN (0,1) AND dw_target  NOT IN (0,1) THEN "DANGER"
                END,"")
                )
            ,"")
        ,IF (transfer_status IN ("REJECTED")
            ,CONCAT(
            IF(source_bank="Movii"
                ,CASE
                    WHEN cico_source_balance=0 AND dwup_source_balance=0 THEN "OK"
                    WHEN cico_source_balance!=0 AND dwup_source_balance=0 THEN CONCAT(-cico_source_balance," cash_source")
                    WHEN cico_source_balance=0 AND dwup_source_balance=-1 THEN "Sign DOWNLOAD_SOURCE no Mahindra"
                    WHEN cico_source_balance=-1 AND dwup_source_balance=-1 THEN "make_DOWNLOAD_SOURCE"
                    WHEN cico_source_balance NOT IN (0,-1) AND dwup_source_balance  NOT IN (0,-1) THEN "DANGER"
                END,""),
            IF(target_bank="Movii"
                ,CASE
                    WHEN cico_target_balance=0 AND dw_target=0 THEN "OK"
                    WHEN cico_target_balance!=0 AND dw_target=0 THEN CONCAT(-cico_target_balance," cash_target")
                    WHEN cico_target_balance=0 AND dw_target!=0 THEN "REJECTED CLOUD REVIEW"
                    WHEN cico_target_balance!=0 AND dw_target!=0 THEN "DANGER"
                END,"")
                )
            ,"")
        ,IF (transfer_status IN ("ERROR","ACCEPTED","INITIATED")
            ,CONCAT(
                IF(dwup_total_balance=0,"CHANGE STATUS","POSIBLE REJECT")
                ,IF(match_source=0 AND match_target=0
                    ,"OK"
                    ,CONCAT(   
                        IF(match_source=0, CONCAT(-cico_source_balance+ dwup_source_balance," cash_source ERROR"),"")
                        ,IF(match_target=0, CONCAT(-cico_target_balance+ dw_target ," cash_target ERROR"),"")
                    )
                )
            )
        ,"")
    ,"") AS Analisis
FROM
    match_table
)