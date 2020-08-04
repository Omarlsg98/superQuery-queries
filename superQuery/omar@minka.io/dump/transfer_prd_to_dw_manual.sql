CREATE OR REPLACE TABLE minka-ach-dw.ach_tin.transfer AS
(
SELECT
   transferId AS transfer_id
    ,txId AS tx_id
    ,source AS source
    ,sourceWallet AS source_wallet
    ,sourceSigner AS source_signer
    ,sourceBank AS source_bank
    ,target AS target
    ,targetWallet AS target_wallet
    ,targetSigner AS target_signer
    ,targetBank AS target_bank
    ,amount AS amount
    ,symbol AS symbol
    ,type AS type
    ,status AS status
    ,description AS description
    ,created AS created
    ,updated AS updated
    ,purpose
    ,sourceChannel AS source_channel
    ,errorCode AS error_code
    ,errorMessage AS error_message
    ,txLabelsId AS tx_labels_id
FROM
    minka-ach-dw.cloudsql_to_bigquery.transfer)