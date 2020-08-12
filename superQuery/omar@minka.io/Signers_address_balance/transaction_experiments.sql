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
    
    OR (transaction_id IS NULL
        AND action_hash IS NOT NULL)
LIMIT 1000