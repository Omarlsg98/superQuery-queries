SELECT CAST(DATE_SUB(CURRENT_DATE("America/Bogota"),INTERVAL 4 DAY) AS STRING) ,  CAST(CURRENT_DATE("America/Bogota") AS STRING);

SELECT CONCAT(TRUE,FALSE);

SELECT
    *
FROM 
    minka-ach-dw.ach_tin.transaction
WHERE
    transaction_id="df386b29014f9f3cbd961ec71567da11a4f5c28127bc98db8a24409e93b3d832"