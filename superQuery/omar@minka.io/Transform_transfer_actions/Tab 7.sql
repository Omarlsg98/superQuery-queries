SELECT
    action_type,COUNT(action_id)
FROM 
    minka-ach-dw.ach_tin_20200702_1159.action
WHERE
    action_transfer_id is null
GROUP BY
    action_type