SELECT
    COUNT(transfer_id)
FROM 
    minka-ach-dw.temp.tx_n_actions
UNION ALL
SELECT
    COUNT(transfer_id)
FROM
    minka-ach-dw.ach_tin_20200702_1159.transfer