SELECT 
    *
FROM minka-ach-dw.ach_tin.action
    where action_type="SEND"
LIMIT 10