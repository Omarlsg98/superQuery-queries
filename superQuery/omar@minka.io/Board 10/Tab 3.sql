SELECT 
   action_id
   ,action_created
FROM
    minka-ach-dw.ach_tin.action
ORDER BY
    action_created DESC
LIMIT
    1000