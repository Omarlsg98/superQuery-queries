SELECT
    action.error_message
    ,COUNT(action_id)
FROM
    minka-ach-dw.ach_tin_20200702_1159.action
GROUP BY
    action.error_message