SELECT
    act.transfer_id
    ,transfer_type
    ,action_id
    ,movii.tx_id
    ,act.action_type AS transfi_type
    ,movii.action_type AS movii_type
    ,action_status
FROM 
    (SELECT
        *
        ,"UPLOAD" as action_type
    FROM 
        minka-ach-dw.movii_bridge_log.movii_status_200702 as movii) AS movii
LEFT JOIN
    minka-ach-dw.ach_tin_20200702_1159.transfer_action AS act
     ON movii.transfer_id=act.transfer_id 
        AND movii.action_type=act.action_type