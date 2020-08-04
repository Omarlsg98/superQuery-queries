SELECT
    * 
FROM 
    minka-ach-dw.ach_tin.transfer
WHERE
    (source_wallet="$573102204561" OR target_wallet="$573102204561")
    AND (source_bank="DAVIPLATA" OR target_bank="DAVIPLATA")
    AND created BETWEEN   "2020-03-29"  AND "2020-04-08"