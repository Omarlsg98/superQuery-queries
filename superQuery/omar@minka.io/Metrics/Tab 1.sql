INSERT INTO
    `minka-ach-dw.metrics.errors`(
    category,
    number,
    measured_on)
SELECT
    "apr-jul" AS category ,COUNT(transfer_id) AS number,  CAST("2020-07-10" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200710
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "2020-04-08" AND "2020-07-08"
UNION ALL
SELECT
    "sep-apr" AS category ,COUNT(transfer_id) AS number,  CAST("2020-07-10" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200710
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "2010-09-10" AND "2020-04-08"
UNION ALL
SELECT
    "jul-now" AS category ,COUNT(transfer_id) AS number, CAST("2020-07-10" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200710
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created > "2020-07-08"
UNION ALL
SELECT
    "all" AS category  ,COUNT(transfer_id) AS number,  CAST("2020-07-10" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200710
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created>"2010-09-10"