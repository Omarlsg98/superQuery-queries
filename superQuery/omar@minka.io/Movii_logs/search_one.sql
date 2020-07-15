WITH 
    action_balance AS 
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
SELECT 
    *
FROM
    action_balance
WHERE
    transfer_id = "knz9wGw0ttSnrN0us"