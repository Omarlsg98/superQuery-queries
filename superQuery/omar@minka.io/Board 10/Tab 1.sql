SELECT 
    *
FROM
    minka-ach-dw.tests.manual_reverse
WHERE
    reported_on>"2020-08-06"
ORDER BY
    reported_on ASC