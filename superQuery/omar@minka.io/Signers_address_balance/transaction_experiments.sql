SELECT

    transaction_id
    ,iou.data.amount
    ,iou.data.source
    ,iou.data.target
    ,__key__.name
    ,__has_error__
    ,created
    ,iou.hash.value
    ,action_hash
    ,action_type
    ,action_status
    ,transfer_id
    ,action_id
    ,action_created
    ,action_udpated
    ,action_source_signer
    ,action_target_signer
    ,error_code
    ,error_message
    ,action_source_bankrouter
    ,action_target_bankrouter
    ,action_source_wallet.handle AS source_wallet
    ,action_target_wallet.handle AS target_wallet
/*
    COUNT(*) AS total
    ,COUNT(action_id) AS actions
    ,COUNT(transaction_id) AS transactions
*/
FROM
    minka-ach-dw.ach_tin.transaction
FULL JOIN
    minka-ach-dw.ach_tin.action
        ON action_hash=iou.hash.value
WHERE
    (transaction_id IS NULL
        AND action_hash IS NOT NULL 
        AND action_hash!="PENDING"
    )
    OR
    (action_id IS NULL 
        AND transaction.created<"2020-08-12"
        AND transaction.created IS NOT NULL
    )