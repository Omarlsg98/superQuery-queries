SELECT 
    SUM(main_action.count) 
    + SUM(upload.count)
    + SUM(download_target.count)
    + SUM(download_source.count)
    + SUM(download_ambiguous.count)
    + SUM(reject.count) as total_actions
    , "tx_n_actions" as descr
FROM
    minka-ach-dw.temp.tx_n_actions
UNION ALL
SELECT
    COUNT(action_id)-2479, "action" as descr
FROM
    minka-ach-dw.ach_tin_20200703_2000.action
WHERE 
    action_type not in ("ISSUE", "TOPUP", "WITHDRAW")
UNION ALL
SELECT
    COUNT(action_id), "action_new_downloads"
FROM 
    minka-ach-dw.temp.action_new_downloads
UNION ALL
SELECT
    SUM(count), "action_summary"
FROM 
    minka-ach-dw.temp.action_summary
ORDER BY total_actions DESC