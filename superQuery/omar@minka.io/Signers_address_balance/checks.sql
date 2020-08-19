#Some searchs
SELECT
    COUNT(DISTINCT iou.data.symbol) AS symbols
    ,COUNT(DISTINCT  __has_error__)  AS has_errors
FROM 
    `minka-ach-dw.ach_tin.transaction`;


#check 1: total balance 
#it must be 0
SELECT
    SUM(balance) AS total
FROM
    `minka-ach-dw.tests.transaction_balance`;

#check 2: signers with negative balance
#It must only be one 
SELECT
    signer
    ,balance
FROM
    `minka-ach-dw.tests.transaction_balance`  
WHERE
    balance<0;
