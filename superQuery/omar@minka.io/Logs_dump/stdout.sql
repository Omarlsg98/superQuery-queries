CREATE TABLE minka-ach-dw.ach_tin_logs.stdout AS
(
SELECT 
    timestamp,textpayload
FROM
    ach-tin-prd.achtin_logs.stdout
)