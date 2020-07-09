SELECT
    COUNT(transfer_id),MAX(created)
FROM 
    minka-ach-dw.temp.tx_n_actions
UNION ALL 
SELECT
    COUNT(transfer_id), MAX(created)
FROM 
    minka-ach-dw.ach_tin.transfer