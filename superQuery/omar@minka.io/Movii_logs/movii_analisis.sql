WITH 
movii_types AS 
(    SELECT 
        SUBSTR(movii_transfer_id,1,2) AS type
        ,transfer_id
        ,amount
    FROM
        minka-ach-dw.movii_bridge_log.movii_logs_20_07_09
    WHERE 
        transfer_status="TS"
)
,movii_balance AS 
(
SELECT 
    transfer_id
    , COUNTIF(type="CI") AS cashins
    , COUNTIF(type="MP") AS cashouts
    , SUM(IF(type="CI",amount,-amount)) AS movii_balance
    , MIN(amount)-MAX(amount) AS healthcheck
FROM
    movii_types
GROUP BY
    transfer_id
)
, action_balance AS 
(
SELECT 
    transfer_id
    , COUNTIF(action_type="DOWNLOAD") AS downloads
    , COUNTIF(action_type="UPLOAD") AS uploads
    , SUM(IF(action_type="DOWNLOAD",-CAST(action_amount AS FLOAT64),CAST(action_amount AS FLOAT64))) AS action_balance
FROM
    minka-ach-dw.ach_tin.action
WHERE
    action_type IN ("DOWNLOAD", "UPLOAD")
    AND action_hash NOT IN ("PENDING")
    AND (action_source_signer="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2" 
        OR action_target_signer="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2")
GROUP BY
    transfer_id
)
,match_table AS 
(
SELECT 
    movii.transfer_id AS movii_transfer_id
    ,action.transfer_id AS action_transfer_id
    ,* EXCEPT (transfer_id)
    ,(movii_balance + action_balance) AS match
FROM
    movii_balance AS movii
LEFT JOIN
    action_balance AS action
        ON action.transfer_id= movii.transfer_id
WHERE
    action.transfer_id IS NOT NULL
)
SELECT
    *
FROM
    match_table
WHERE
    match!=0