SELECT
    movii.transfer_id
FROM
    minka-ach-dw.movii_bridge_log.movii_status_200702 AS movii
INNER JOIN 
    minka-ach-dw.ach_tin_20200701_1415.transfer_one_action_error AS ae
        ON UPPER(ae.transfer_id)=movii.transfer_id