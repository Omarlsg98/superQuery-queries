SELECT 
    COUNT(transfer_id)
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("REJECTED", "COMPLETED","PENDING")
    AND created > "2020-07-08"