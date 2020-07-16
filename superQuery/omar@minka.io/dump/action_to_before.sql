CREATE TABLE minka-ach-dw.ach_tin_before.action_20200716
AS (
SELECT
    action_id
    , source AS action_source
    , target AS action_target
    , amount AS action_amount
    , symbol AS action_symbol
    , labels.tx_ref AS transfer_id
    , labels.tx_id AS action_tx_id
    , labels.type AS action_type
    , labels.status AS action_status
    , labels.description AS action_desc
    , labels.created AS action_created
    , labels.updated AS action_udpated
    , labels.hash AS action_hash
    , error.code.integer AS error_code
    , error.message.string AS error_message
    , snapshot.source.signer.labels.bankName AS action_source_bankname
    , snapshot.source.signer.labels.bankAccountType AS action_source_bankaccounttype
    , snapshot.source.signer.labels.bankAccountNumber AS action_source_bankaccountnum
    , snapshot.source.signer.labels.routerReference AS action_source_bankrouter
    , snapshot.source.wallet.handle AS action_source_wallet
    , snapshot.source.signer.handle AS action_source_signer
    , snapshot.target.signer.labels.bankName AS action_target_bankname
    , snapshot.target.signer.labels.bankAccountType AS action_target_bankaccounttype
    , snapshot.target.signer.labels.bankAccountNumber AS action_target_bankaccountnum
    , snapshot.target.signer.labels.routerReference AS action_target_bankrouter
    , snapshot.target.wallet.handle AS action_target_wallet
    , snapshot.target.signer.handle AS action_target_signer
FROM 
    ach-tin-prd-multireg.ach_tin_prod_datastore.action
)