SELECT 
    COUNT(movii.transfer_id)
    ,COUNT (transfer.trasnfer_id)
FROM
    movii_bridge_log.movii_logs_all AS movii
INNER JOIN 
    minka-ach-dw.ach_tin.transfer ON LOWER(transfer.transfer_id)=LOWER(movii.cell_id)