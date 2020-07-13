SELECT
    transfer.transfer_id
    ,source_signer
    ,source.signer AS source
    ,target_signer
    ,target.signer AS target
    ,source.balance AS source_signer_balance
    ,target.balance AS target_signer_balance
FROM
    minka-ach-dw.ach_tin.transfer
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS source ON transfer.source_signer=source.signer
LEFT JOIN 
    minka-ach-dw.ach_tin.signer_balance AS target ON transfer.target_signer=target.signer
WHERE 
    transfer_id="0uNXBEXl6yRCdFZnq"
LIMIT 100;

SELECT * 
FROM minka-ach-dw.ach_tin.transaction
WHERE source="wVzSoMesmjhZfz8Jvrdn6ryYuPvPhc7uWA" OR target="wVzSoMesmjhZfz8Jvrdn6ryYuPvPhc7uWA"