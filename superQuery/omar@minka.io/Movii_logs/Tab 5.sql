DROP TABLE  minka-ach-dw.movii_bridge_log.movii_logs_20_07_09;
CREATE TABLE minka-ach-dw.movii_bridge_log.movii_logs_20_07_09 AS (
SELECT
    *
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_09_date
)