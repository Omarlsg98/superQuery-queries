#CREATE OR REPLACE TABLE minka-ach-dw.movii_bridge_log.movii_logs_transform AS (
WITH both_movii AS 
(
    SELECT
        IFNULL(niw.msisdn, CAST(old.msisdn AS STRING)) AS msisdn
        , IFNULL(niw.cell_id, old.cell_id) AS cell_id
        , IFNULL(niw.ftxn_id, old.ftxn_id) AS ftxn_id
        , IFNULL(niw.service_type, old.service_type) AS service_type
        , IFNULL(niw.transfer_id, old.transfer_id) AS transfer_id
        , IFNULL(niw.transfer_on, old.transfer_on) AS transfer_on
        , IFNULL(niw.value, old.value) AS value
        , IFNULL(niw.error_code, old.error_code) AS error_code
        , IFNULL(niw.transfer_status, old.transfer_status) AS transfer_status
    FROM 
        minka-ach-dw.movii_bridge_log.movii_logs_2020_07_29 AS niw
    FULL JOIN
        minka-ach-dw.movii_bridge_log.movii_logs_20_07_16 AS old
            ON LOWER(niw.transfer_id)=LOWER(old.transfer_id)
)
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
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_16 AS movii
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer ON LOWER(transfer.transfer_id)=LOWER(movii.cell_id)
WHERE
    transfer.transfer_id IS NOT NULL
LIMIT 100
#)