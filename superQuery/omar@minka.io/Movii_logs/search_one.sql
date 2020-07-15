SELECT
    *
FROM
    minka-ach-dw.movii_bridge_log.movii_logs_20_07_09
WHERE
    cell_id=UPPER("knz9wGw0ttSnrN0us")
    AND transfer_status="TS"