DROP TABLE minka-ach-dw.ach_tin_logs.stderr ;
CREATE TABLE minka-ach-dw.ach_tin_logs.stderr AS
(
SELECT 
    *
FROM
    ach-tin-prd.achtin_logs.stderr
)