/*Backup Movii ALL*/
CREATE OR REPLACE TABLE minka-ach-dw.ach_tin_before.movii_logs_all_backup AS (
SELECT
    *
FROM 
    movii_bridge_log.movii_logs_all);

/*Merge new logs of movii with old ones*/
CREATE OR REPLACE TABLE minka-ach-dw.movii_bridge_log.movii_logs_all AS (
SELECT
    IFNULL(CAST(niw.msisdn AS STRING), old.msisdn) AS msisdn
    , IFNULL(niw.cell_id, old.cell_id) AS cell_id
    , IFNULL(NULL, old.ftxn_id) AS ftxn_id
    , IFNULL(niw.service_type, old.service_type) AS service_type
    , IFNULL(niw.transfer_id, old.transfer_id) AS transfer_id
    , IFNULL(niw.transfer_on, old.transfer_on) AS transfer_on
    , IFNULL(niw.value, old.value) AS value
    , IFNULL(niw.error_code, old.error_code) AS error_code
    , IFNULL(niw.transfer_status, old.transfer_status) AS transfer_status
FROM 
    minka-ach-dw.movii_bridge_log.movii_logs_2020_08_18 AS niw
FULL JOIN
    minka-ach-dw.movii_bridge_log.movii_logs_all AS old
        ON LOWER(niw.transfer_id)=LOWER(old.transfer_id)
);


SELECT
    transfer_id
    ,COUNT(transfer_id) AS conteo
FROM
    movii_bridge_log.movii_logs_all
GROUP BY
    transfer_id
HAVING 
    conteo>1;


SELECT
    MAX(transfer_on) as MAX, "logs_all"
FROM 
    minka-ach-dw.movii_bridge_log.movii_logs_all
UNION ALL
SELECT
    MAX(created) as MAX , "transform"
FROM 
    minka-ach-dw.movii_bridge_log.movii_logs_transform;
    
    