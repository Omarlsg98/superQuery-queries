SELECT 
    * 
FROM 
    minka-ach-dw.ach_tin.wallet
WHERE
    labels.bankName IS NOT NULL
    AND 
    labels.routerUpload IS NOT NULL
LIMIT 10