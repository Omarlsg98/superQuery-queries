SELECT
   action_type
FROM
    minka-ach-dw.ach_tin.action
GROUP BY
    action_type
LIMIT 100