SELECT
    transfer.transfer_id
    ,source_signer
    ,source.signer AS source
    ,target_signer
    ,target.signer AS target
    ,source.balance
FROM
    minka-ach-dw.ach_tin.transfer
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS source ON transfer.source_signer=source.signer
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS target ON transfer.target_signer=target.signer
WHERE 
    status="ERROR"
LIMIT 100