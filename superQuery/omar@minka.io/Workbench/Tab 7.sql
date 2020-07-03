SELECT
    movii.movii_status
    ,review.transfer_id
FROM 
    minka-ach-dw.movii_bridge_log.ach_bank_review AS review
INNER JOIN
    minka-ach-dw.movii_bridge_log.movii_status_200702 as movii
        ON movii.transfer_id=UPPER(review.transfer_id)
WHERE 
    movii.movii_status IN ("Cambio de estado")