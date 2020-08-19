SELECT
    *
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_all
WHERE 
    LOWER(transfer_id) =LOWER("MP200413.1920.E00377")