SELECT 
    handle
    ,labels.mobile
    ,labels.created
    ,labels.bankName
FROM 
    minka-ach-dw.ach_tin.signer
WHERE
    mobile IN (
    "573176357560",
"573205912747",
"573118279224",
"573133813136")