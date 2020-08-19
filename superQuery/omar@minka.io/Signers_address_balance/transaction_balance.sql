SELECT
    signer
    ,balance
FROM
    `minka-ach-dw.tests.transaction_balance`  
WHERE
    balance<0