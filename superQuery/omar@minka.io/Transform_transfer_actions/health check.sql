SELECT
    COUNT(transfer_id),MAX(created)
FROM 
    minka-ach-dw.temp.tx_n_actions
UNION ALL
SELECT
    COUNT(transfer_id), MAX(created)
FROM
    minka-ach-dw.ach_tin_20200702_1159.transfer;
SELECT 
    SUM(main_action.count) 
    + SUM(upload.count)
    + SUM(download_target.count)
    + SUM(download_source.count)
    + SUM(download_ambiguous.count)
    + SUM(reject.count) as total_actions
FROM
    minka-ach-dw.temp.tx_n_actions
UNION ALL
SELECT
    count(action_id)
FROM
    minka-ach-dw.ach_tin_20200702_1159.action
WHERE 
    action_type not in ("ISSUE", "TOPUP", "WITHDRAW")
    