/*INSERT INTO
    `minka-ach-dw.metrics.errors`(
    category,
    number,
    measured_on)*/
SELECT
    "apr-jul" ,COUNT(transfer_id),  CAST(CURRENT_DATETIME("America/Bogota") AS TIMESTAMP)
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "2020-04-08" AND "2020-07-08"
UNION ALL
SELECT
    "sep-apr" ,COUNT(transfer_id),  CAST(CURRENT_DATETIME("America/Bogota") AS TIMESTAMP)
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created < "2020-04-08"
UNION ALL
SELECT
    "jul-now" ,COUNT(transfer_id),  CAST(CURRENT_DATETIME("America/Bogota") AS TIMESTAMP)
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created > "2020-07-08"
UNION ALL
SELECT
    "all" ,COUNT(transfer_id),  CAST(CURRENT_DATETIME("America/Bogota") AS TIMESTAMP)
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created>"2020-09-13"