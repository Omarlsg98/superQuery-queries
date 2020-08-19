CREATE OR REPLACE TABLE minka-ach-dw.movii_bridge_log.movii_logs_all AS (
SELECT
    IFNULL(CAST(niw.msisdn AS STRING), old.msisdn) AS msisdn
    , IFNULL(niw.cell_id, old.cell_id) AS cell_id 
    , IFNULL(CONCAT(niw.product_name,niw.all_remarks), old.ftxn_id) AS ftxn_id
    , IFNULL(niw.service_type, old.service_type) AS service_type
    , IFNULL(niw.transfer_id, old.transfer_id) AS transfer_id
    , IFNULL(niw.transfer_on, old.transfer_on) AS transfer_on
    , IFNULL(niw.value, old.value) AS value
    , IFNULL(NULL, old.error_code) AS error_code
    , IFNULL(niw.transfer_status, old.transfer_status) AS transfer_status
FROM 
    minka-ach-dw.movii_bridge_log.movii_manual_ids AS niw
FULL JOIN
    minka-ach-dw.movii_bridge_log.movii_logs_all AS old
        ON LOWER(niw.transfer_id)=LOWER(old.transfer_id)
)