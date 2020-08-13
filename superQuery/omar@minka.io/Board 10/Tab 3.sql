SELECT 
   action_type
   ,action_status
   ,COUNT(action_id)
FROM
    minka-ach-dw.ach_tin.action
GROUP BY
    action_type
    ,action_status