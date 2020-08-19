SELECT
    signer
    ,balance AS calc_balance
FROM
    `minka-ach-dw.tests.transaction_balance`
WHERE
    (balance>0 AND RAND()>0.01)
    OR
    (balance=0 AND RAND()>0.01)