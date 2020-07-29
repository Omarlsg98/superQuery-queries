
SELECT
    "apr-jul" AS category ,COUNT(transfer_id) AS number,  CAST(CURRENT_DATETIME("America/Bogota") AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "2020-04-08" AND "2020-07-08"
UNION ALL
SELECT
    "sep-apr" AS category ,COUNT(transfer_id) AS number,  CAST(CURRENT_DATETIME("America/Bogota") AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "2019-09-13" AND "2020-04-08"
UNION ALL
SELECT
    "jul-now" AS category ,COUNT(transfer_id) AS number,  CAST(CURRENT_DATETIME("America/Bogota") AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    (status NOT IN ("REJECTED", "COMPLETED")
        OR (status IN ("PENDING")  AND CAST(SUBSTR(created,1,19) AS DATETIME) < DATETIME_SUB(CURRENT_DATETIME("America/Bogota"),INTERVAL 30 HOUR))
    )
    AND created > "2020-07-08"
UNION ALL
SELECT
    "all" AS category  ,COUNT(transfer_id) AS number,  CAST(CURRENT_DATETIME("America/Bogota") AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created>"2019-09-13"