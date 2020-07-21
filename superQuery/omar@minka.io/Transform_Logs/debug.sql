SELECT
    timestamp
    ,text_pay_load
FROM
    minka-ach-dw.ach_tin_logs.both_logs_deduplicated
WHERE
    text_pay_load like "%mDNOHvVK7qHlS91zp%"