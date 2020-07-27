INSERT INTO
    `minka-ach-dw.metrics.errors`(
    category,
    number,
    measured_on)
SELECT
    "apr-jul" AS category ,COUNT(transfer_id) AS number,  CAST("1919-07-19" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_19190719
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "1919-04-08" AND "1919-07-08"
UNION ALL
SELECT
    "sep-apr" AS category ,COUNT(transfer_id) AS number,  CAST("1919-07-19" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_19190719
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "1919-09-13" AND "1919-04-08"
UNION ALL
SELECT
    "jul-now" AS category ,COUNT(transfer_id) AS number, CAST("1919-07-19" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_19190719
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created > "1919-07-08"
UNION ALL
SELECT
    "all" AS category  ,COUNT(transfer_id) AS number,  CAST("1919-07-19" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_19190719
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created>"1919-09-13"