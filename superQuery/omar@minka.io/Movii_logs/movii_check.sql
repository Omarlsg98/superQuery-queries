SELECT
    *
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_all
WHERE 
    LOWER(transfer_id) =LOWER("CI200316.1725.A01734")