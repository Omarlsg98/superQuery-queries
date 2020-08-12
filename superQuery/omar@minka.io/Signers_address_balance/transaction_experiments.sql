SELECT
    /*transaction_id
    ,iou.data.amount
    ,iou.data.source
    ,iou.data.target
    ,__key__.name
    ,__has_error__
    ,created
    ,iou.hash.value
    ,action_hash*/
    COUNT(*)
    ,COUNT(action_id)
    ,COUNT(transaction_id)
FROM
    minka-ach-dw.ach_tin.transaction
FULL JOIN
    minka-ach-dw.temp.action_new_downloads
        ON action_hash=iou.hash.value
WHERE
    (action_id IS NULL
        AND transaction.created<"2020-08-12")
    OR (transaction_id IS NULL
        AND action_hash IS NOT NULL)