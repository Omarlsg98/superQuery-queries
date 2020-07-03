CREATE TABLE minka-ach-dw.ach_tin_logs.winston_log AS
(
SELECT 
    timestamp,jsonPayload.message
FROM
    ach-tin-prd.achtin_logs.winston_log
)