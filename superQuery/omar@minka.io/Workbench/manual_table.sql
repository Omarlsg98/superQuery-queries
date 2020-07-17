SELECT
    CAST(SUBSTR(created,1,10) AS DATE)
FROM 
    minka-ach-dw.ach_tin.transfer
LIMIT 100