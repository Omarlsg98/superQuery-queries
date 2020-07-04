SELECT
    review.transfer_id
    ,movii.movii_status
    ,bank_approval
FROM 
    minka-ach-dw.movii_bridge_log.ach_bank_review AS review
LEFT JOIN
    minka-ach-dw.movii_bridge_log.movii_status_200702 as movii
        ON movii.transfer_id=UPPER(review.transfer_id)
WHERE 
     bank_approval IN ("Davivienda","DAVIPLATA")