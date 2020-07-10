SELECT created ,CAST(SUBSTR(created,1,19) AS DATETIME), DATETIME_SUB(CURRENT_DATETIME("America/Bogota"),INTERVAL 1 DAY)
FROM 
    minka-ach-dw.ach_tin.transfer
LIMIT 10