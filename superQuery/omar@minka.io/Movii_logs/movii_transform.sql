CREATE TABLE minka-ach-dw.movii_bridge_log.movii_logs_20_07_16_temp AS (
SELECT
    transfer.transfer_id AS transfer_id
    ,movii.transfer_id AS movii_transfer_id 
    ,CONCAT("57",msisdn) AS cellphone
    ,cell_id AS cell_id
    ,ftxn_id
    ,service_type
    ,transfer_on AS created
    ,value AS amount
    ,movii.error_code AS error_code
    ,transfer_status AS transfer_status
FROM 
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_16 AS movii
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer ON transfer.transfer_id=movii.cell_id 
WHERE
    transfer.transfer_id IS NOT NULL
UNION DISTINCT
SELECT
    transfer.transfer_id AS transfer_id
    ,movii.transfer_id AS movii_transfer_id 
    ,CONCAT("57",msisdn) AS cellphone
    ,cell_id AS cell_id
    ,ftxn_id
    ,service_type
    ,transfer_on AS created
    ,value AS amount
    ,movii.error_code AS error_code
    ,transfer_status AS transfer_status
FROM 
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_16 AS movii
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer ON UPPER(transfer.transfer_id)=movii.cell_id 
WHERE
    transfer.transfer_id IS NOT NULL
)