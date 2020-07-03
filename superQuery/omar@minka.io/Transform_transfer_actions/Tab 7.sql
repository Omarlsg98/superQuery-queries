SELECT
    COUNT(action_id)
FROM 
    minka-ach-dw.ach_tin_20200702_1159.action
WHERE
    action_transfer_id is null
    OR action_transfer_id NOT IN (
    SELECT transfer_id FROM minka-ach-dw.ach_tin_20200702_1159.transfer)