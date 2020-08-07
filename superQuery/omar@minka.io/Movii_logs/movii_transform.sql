SELECT
    movii.*
FROM
    movii_bridge_log.movii_logs_all AS movii
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer ON LOWER(transfer.transfer_id)=LOWER(movii.cell_id)
WHERE
    transfer.transfer_id IS NULL