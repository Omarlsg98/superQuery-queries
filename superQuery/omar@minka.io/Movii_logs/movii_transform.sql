CREATE OR REPLACE TABLE minka-ach-dw.movii_bridge_log.movii_logs_transform AS (
SELECT
    transfer.transfer_id AS transfer_id
    ,movii.transfer_id AS movii_transfer_id 
    ,CONCAT("$57",msisdn) AS cellphone
    ,cell_id AS cell_id
    ,ftxn_id
    ,IF(transfer.source_wallet=CONCAT("$57",msisdn) AND source_bank="Movii","SOURCE","TARGET") AS tx_place
    ,service_type
    ,transfer_on AS created
    ,value AS amount
    ,movii.error_code AS error_code
    ,transfer_status AS transfer_status
FROM 
    movii_bridge_log.movii_logs_all AS movii
INNER JOIN 
    minka-ach-dw.ach_tin.transfer ON LOWER(transfer.transfer_id)=LOWER(movii.cell_id)
)