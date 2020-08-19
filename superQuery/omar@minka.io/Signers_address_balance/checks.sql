SELECT
    COUNT(signer)
FROM
    minka-ach-dw.tests.transaction_balance
WHERE
    balance>0