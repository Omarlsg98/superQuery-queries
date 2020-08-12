CREATE OR REPLACE TABLE minka-ach-dw.ach_tin.transaction AS 
(
    SELECT
        *
    FROM
        ach-tin-prd-multireg.ach_tin_prod_datastore.transaction
)