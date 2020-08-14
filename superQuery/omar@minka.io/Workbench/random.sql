SELECT
   action_type
FROM
    minka-ach-dw.ach_tin.action
WHERE
    action_type IN ("WITHDRAW")
LIMIT 100