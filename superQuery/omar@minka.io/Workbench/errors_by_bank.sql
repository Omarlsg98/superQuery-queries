SELECT
    IF(status="ACCEPTED", target_bank,source_bank) AS bank
    ,COUNT(transfer_id) as no_continues
FROM
    minka-ach-dw.ach_tin.transfer
GROUP BY    
    bank