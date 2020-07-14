/*transaction*/
DROP TABLE minka-ach-dw.ach_tin.transaction;
CREATE TABLE minka-ach-dw.ach_tin.transaction AS
(
SELECT
   * 
FROM
    ach-tin-prd-multireg.ach_tin_prod_datastore.transaction);
/*wallet*/
DROP TABLE minka-ach-dw.ach_tin.wallet;
CREATE TABLE minka-ach-dw.ach_tin.wallet AS
(
SELECT
   * 
FROM
    ach-tin-prd-multireg.ach_tin_prod_datastore.wallet);
/*signer*/
DROP TABLE minka-ach-dw.ach_tin.signer;
CREATE TABLE minka-ach-dw.ach_tin.signer AS
(
SELECT
   * 
FROM
    ach-tin-prd-multireg.ach_tin_prod_datastore.signer);
/*link*/
DROP TABLE minka-ach-dw.ach_tin.signer;
CREATE TABLE minka-ach-dw.ach_tin.signer AS
(
SELECT
   * 
FROM
    ach-tin-prd-multireg.ach_tin_prod_datastore.signer);