SELECT
    COUNT(*)
FROM
    minka-ach-dw.ach_tin.transfer
WHERE 
    transfer_id IS NULL