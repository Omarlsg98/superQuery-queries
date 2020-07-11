CREATE TABLE minka-ach-dw.movii_bridge_log.movii_logs_20_07_09 AS (
SELECT
    transfer.transfer_id AS transfer_id
    ,movii.transfer_id AS movii_transfer_id 
    ,movii.* EXCEPT(transfer_id)
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_2020_07_09_change_date AS movii
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer ON transfer.transfer_id=movii.cell_id 
WHERE
    transfer.transfer_id IS NOT NULL
UNION distinct
SELECT
    transfer.transfer_id AS transfer_id
    ,movii.transfer_id AS movii_transfer_id
    ,movii.* EXCEPT(transfer_id)
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_2020_07_09_change_date AS movii
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer ON UPPER(transfer.transfer_id)=movii.cell_id
WHERE
    transfer.transfer_id IS NOT NULL
)