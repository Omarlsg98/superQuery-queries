SELECT
    *
FROM 
    minka-ach-dw.temp.movii_match
WHERE
    movii_transfer_id IS NULL
LIMIT 1000