SELECT 
    *
FROM minka-ach-dw.ach_tin.action
    where action_type="SEND" and action_created>"2020-07-01"
LIMIT 10