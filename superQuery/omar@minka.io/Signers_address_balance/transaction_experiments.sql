SELECT
    COUNT(*)
FROM
    minka-ach-dw.ach_tin.transaction
FULL JOIN
    minka-ach-dw.temp.action_new_downloads
        ON action_hash=iou.hash.value
WHERE
    action_id IS NULL
    OR transaction_id IS NULL