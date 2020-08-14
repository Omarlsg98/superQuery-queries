/*Backup Movii ALL*/
CREATE OR REPLACE TABLE minka-ach-dw.ach_tin_before.movii_logs_all_backup AS (
SELECT
    *
FROM 
    movii_bridge_log.movii_logs_all)