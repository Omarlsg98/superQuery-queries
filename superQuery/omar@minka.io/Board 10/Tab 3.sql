SELECT 
   action_type
   ,COUNT(action_id)
FROM
    minka-ach-dw.ach_tin.action
GROUP BY
    action_type