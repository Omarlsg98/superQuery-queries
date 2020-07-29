SELECT
    transfer.transfer_id
    ,source.balance AS source_signer_balance
    ,target.balance AS target_signer_balance
FROM
    minka-ach-dw.ach_tin.transfer
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS source ON transfer.source_signer=source.signer
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS target ON transfer.target_signer=target.signer