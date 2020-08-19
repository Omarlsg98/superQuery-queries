SELECT
    *
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_all
WHERE 
    transfer_id IN ("CI200316.1725.A01734",
"CI200512.1450.A01593",
"CI200513.1435.A02364",
"CI200528.1940.A00842")