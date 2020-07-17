SELECT
    CAST(SUBSTR(created,1,8) AS DATE)
FROM 
    minka-ach-dw.ach_tin.transfer
LIMIT 100