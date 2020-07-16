SELECT
    transfer_id
    ,status
    ,type
    ,error_code
    ,error_message
FROM    
    minka-ach-dw.ach_tin.transfer
WHERE
    source_bank IS NULL
    AND status NOT IN ("REJECTED","COMPLETED")