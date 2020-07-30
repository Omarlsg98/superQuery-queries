SELECT 
    MAX(action_created),"action"
FROM
    minka-ach-dw.ach_tin.action
UNION ALL
SELECT 
    MAX(created),"transfer"
FROM
    minka-ach-dw.ach_tin.transfer