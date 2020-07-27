SELECT
    "apr-jul" AS category ,COUNT(transfer_id) AS number,  CAST("2020-07-01" AS TIMESTAMP) AS measured_on
FROM
    minka-ach-dw.ach_tin_before.transfer_20200701
WHERE
    status NOT IN ("REJECTED", "COMPLETED")
    AND created BETWEEN "2020-04-08" AND "2020-07-08"