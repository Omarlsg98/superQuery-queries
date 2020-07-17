SELECT
    COUNT(*)
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_16_temp
UNION ALL
SELECT
    COUNT(*)
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_16