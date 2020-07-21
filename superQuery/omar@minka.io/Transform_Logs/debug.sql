SELECT
    timestamp
    ,payload
FROM
    minka-ach-dw.ach_tin_logs.both_logs_deduplicated
WHERE
    payload like "%mDNOHvVK7qHlS91zp%"
ORDER BY 
    timestamp ASC