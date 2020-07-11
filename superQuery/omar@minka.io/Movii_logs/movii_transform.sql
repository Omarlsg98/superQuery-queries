DROP TABLE minka-ach-dw.movii_bridge_log.movii_logs_20_07_09_date
CREATE TABLE minka-ach-dw.movii_bridge_log.movii_logs_20_07_09_date AS (
SELECT
    movii.* EXCEPT(transfer_id)
    , change_date.transfer_on AS created
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_09 AS movii
LEFT JOIN 
    minka-ach-dw.movii_bridge_log.movii_logs_2020_07_09_change_date change_date ON change_date.transfer_id=movii_transfer_id 
)