SELECT
    * 
FROM 
    minka-ach-dw.ach_tin.transfer
WHERE
    (source_wallet="$573102204561" OR target_wallet="$573102204561")