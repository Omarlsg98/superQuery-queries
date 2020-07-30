SELECT 
    handle
    ,labels.mobile
    ,labels.created
    ,labels.bankName
FROM 
    minka-ach-dw.ach_tin.signer
WHERE
    handle IN ("wYoqKKqis1xq4dXYVFo8JF1KjkED1Gaxf7",
                "wWbgfXVtDda9jkHPwY6wgamFEHtCQEBXDK",
                "wbQ4JP87EZyyc4wfUfLG98Arh1qNZr2DuT",
                "wdzEtchJiJwfc2pTQbqVGJ8RD9rbJD3CER")