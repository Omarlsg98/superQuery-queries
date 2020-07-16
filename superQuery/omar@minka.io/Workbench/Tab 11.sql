SELECT
    transfer_id
FROM    
    minka-ach-dw.ach_tin.transfer
WHERE
    source_bank IS NULL