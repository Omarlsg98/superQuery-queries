CREATE OR REPLACE TABLE  minka-ach-dw.movii_bridge_log.movii_diferencia_14_07_2020 AS (
SELECT
    transfer.transfer_id AS transfer_id
    ,movii.*
FROM 
     minka-ach-dw.movii_bridge_log.movii_diferencia_14_07_2020 AS movii
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer ON LOWER(transfer.transfer_id)=LOWER(movii.movii_transfer_id)
WHERE
    transfer.transfer_id IS NOT NULL
)