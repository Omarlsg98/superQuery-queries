SELECT
   * 
FROM
   EXTERNAL_QUERY("us-east4.ach_tin_prd",
                  '''
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
                    ,labels->'$.transactionPurpose' AS purpose
                    ,labels->'$.sourceChannel' AS source_channel
                    ,labels->'$.source.signer.labels.routerReference' AS source_signer_router
                    ,labels->'$.source.signer.labels.bankAccountNumber' AS source_signer_bank_account_number
                    ,labels->'$.target.signer.labels.routerReference' AS target_signer_router
                    ,labels->'$.target.signer.labels.bankAccountNumber' AS target_signer_bank_account_number
                    ,labels->'$.tx_id' AS tx_labels_id
                    ,error->'$.code' AS error_code
                    ,error->'$.message' AS error_message
                  FROM
                    transfer
                  ''')