SELECT
    COUNT(*), "--"
FROM 
    minka-ach-dw.movii_bridge_log.ach_bank_review
UNION ALL
SELECT
    COUNT(*), "OK"
FROM 
    minka-ach-dw.movii_bridge_log.ach_bank_review_movii_ok