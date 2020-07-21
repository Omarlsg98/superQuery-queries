SELECT 
    * 
FROM 
    minka-ach-dw.ach_tin.wallet
WHERE
    labels.routerUpload IS NOT NULL
LIMIT 10