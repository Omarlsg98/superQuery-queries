SELECT
    * 
FROM 
    minka-ach-dw.ach_tin.transfer
WHERE
    (source_wallet="$573168059182" OR target_wallet="$573168059182")
    AND (source_bank="Movii" OR target_bank="Movii")
    AND created BETWEEN "2020-03-07" AND "2020-03-30"