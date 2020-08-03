DROP VIEW minka-ach-dw.ach_tin.transfer_action;

SELECT
    COUNT(action_id)
FROM 
    minka-ach-dw.ach_tin.transfer_action
WHERE
    transfer_source_signer!=action_source_signer
    AND


SELECT
    transfer_id
    ,created
FROM 
    minka-ach-dw.ach_tin.transfer
WHERE 
    status NOT IN ("REJECTED","COMPLETED")
    AND source_channel IS NULL;

/*Signers fantasma*/
SELECT
    *
FROM 
    minka-ach-dw.ach_tin.transaction
WHERE
    transaction_id LIKE "%df386b29014f9f3cbd961ec71567da11a4f5c28127bc98db8a24409e93b3d832%";
    
SELECT 
    handle
    ,labels.mobile
    ,labels.created
    ,labels.bankName
FROM 
    minka-ach-dw.ach_tin.signer
WHERE
    labels.mobile IN (
    "573176357560",
"573205912747",
"573118279224",
"573133813136");
    handle IN ("wYoqKKqis1xq4dXYVFo8JF1KjkED1Gaxf7",
                "wWbgfXVtDda9jkHPwY6wgamFEHtCQEBXDK",
                "wbQ4JP87EZyyc4wfUfLG98Arh1qNZr2DuT",
                "wdzEtchJiJwfc2pTQbqVGJ8RD9rbJD3CER");

SELECT 
    *
FROM 
    minka-ach-dw.ach_tin.transfer
WHERE
    target_wallet IN (
    "$573176357560",
"$573205912747",
"$573118279224",
"$573133813136");