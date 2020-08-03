SELECT
    CounT(transfer_id)
FROM 
    minka-ach-dw.ach_tin.transfer
WHERE 
    status NOT IN ("REJECTED","COMPLETED")
    AND source_channel IS NULL