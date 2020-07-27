INSERT INTO
    `minka-ach-dw.metrics.errors`(
    category,
    number,
    measured_on)
SELECT
    "apr-jul" AS category ,COUNT(transfer_id) AS number,  CAST("2020-07-11" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200711
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "2020-04-08" AND "2020-07-08"
UNION ALL
SELECT
    "sep-apr" AS category ,COUNT(transfer_id) AS number,  CAST("2020-07-11" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200711
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "2011-09-11" AND "2020-04-08"
UNION ALL
SELECT
    "jul-now" AS category ,COUNT(transfer_id) AS number, CAST("2020-07-11" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200711
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created > "2020-07-08"
UNION ALL
SELECT
    "all" AS category  ,COUNT(transfer_id) AS number,  CAST("2020-07-11" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200711
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created>"2011-09-11"