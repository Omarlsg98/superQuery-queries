SELECT CAST(SUBSTR(created,1,19) AS DATETIME),created
FROM 
    minka-ach-dw.ach_tin.transfer
LIMIT 10