CREATE OR REPLACE TABLE minka-ach-dw.ach_tin.transfer AS
(
SELECT
   * 
FROM
    ach-tin-prd.sql_dump.transfer)