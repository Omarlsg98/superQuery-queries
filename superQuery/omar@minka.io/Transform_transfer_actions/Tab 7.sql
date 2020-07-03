SELECT
    action_type,COUNT(action_id)
FROM 
    minka-ach-dw.ach_tin_20200702_1159.action
GROUP BY
    action_type