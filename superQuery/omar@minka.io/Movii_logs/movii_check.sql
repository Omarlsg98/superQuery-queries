SELECT
    COUNT(*),MAX(created),MIN(created),"transform"
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_transform
UNION ALL
SELECT
    COUNT(*),MAX(transfer_on),MIN(transfer_on),"logs"
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_16