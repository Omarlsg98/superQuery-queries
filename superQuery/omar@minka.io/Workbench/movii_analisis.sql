WITH 
movii_types AS 
(    SELECT 
        SUBSTR(TRANSFER_ID,1,2) AS type
        ,CELL_ID AS transfer_id
        ,ERROR_CODE AS amount
    FROM
        `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09`
    WHERE 
        string_field_7="TS"
)
,movii_balance AS 
(
SELECT 
    transfer_id
    , COUNTIF(type="CI") AS cashins
    , COUNTIF(type="MP") AS cashouts
    , SUM(IF(type="CI",amount,-amount)) AS balance
    , MIN(amount)-MAX(amount) AS healthcheck
FROM
    movii_types
GROUP BY
    transfer_id
)
, actions_balance AS 
(
SELECT 
    transfer_id
    , COUNTIF(action_type="DOWNLOAD") AS downloads
    , COUNTIF(action_type="UPLOAD") AS uploads
    , SUM(IF(action_type="DOWNLOAD",-CAST(action_amount AS FLOAT64),CAST(action_amount AS FLOAT64))) AS balance
FROM
    minka-ach-dw.ach_tin.action
WHERE
    action_type IN ("DOWNLOAD", "UPLOAD")
    AND (action_source_signer="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2" 
        OR action_target_signer="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2")
GROUP BY
    transfer_id
)
SELECT 
    * 
FROM
    actions_balance
LIMIT 10