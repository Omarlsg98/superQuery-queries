SELECT
    COUNT(*)
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("COMPLETED","REJECTED")