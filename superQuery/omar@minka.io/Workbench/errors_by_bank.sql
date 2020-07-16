SELECT
    IF(status="ACCEPTED", target_bank,source_bank) AS bank
    ,COUNT(transfer_id) as no_continues
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    created>"2020-04-08"
    AND status IN ("ACCEPTED","INITIATED")
GROUP BY    
    bank