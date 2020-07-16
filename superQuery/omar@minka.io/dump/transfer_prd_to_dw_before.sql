DROP TABLE minka-ach-dw.ach_tin_before.transfer_20200716_0900;
CREATE TABLE minka-ach-dw.ach_tin_before.transfer_20200716_0900 AS
(
SELECT
   * 
FROM
    ach-tin-prd.sql_dump.transfer);