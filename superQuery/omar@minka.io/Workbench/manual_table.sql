SELECT
    DATE(SUBSTR(created,1,8))
FROM 
    minka-ach-dw.ach_tin.transfer
LIMIT 100