SELECT
    transfer_id
    ,transfer_type
    ,transfer_status
    ,action_id
    ,action_type
    ,action_status
    ,action_hash
    ,action_source_bank
    ,action_target_bank
    ,transfer_source_bank
    ,transfer_target_bank
FROM
    minka-ach-dw.ach_tin_20200701_1415.transfer_action
WHERE 
    transfer_id IN (
        SELECT action_transfer_id
        FROM minka-ach-dw.ach_tin_20200701_1415.action
        WHERE action_type="UPLOAD" AND action_status="COMPLETED")
    AND 
     transfer_id IN (
        SELECT action_transfer_id
        FROM minka-ach-dw.ach_tin_20200701_1415.action
        WHERE action_type="SEND" AND action_status="REJECTED")
    AND
     transfer_id IN (
        SELECT action_transfer_id
        FROM minka-ach-dw.ach_tin_20200701_1415.action
        WHERE action_type="DOWNLOAD" AND action_status="COMPLETED")
     AND
     transfer_id NOT IN (
        SELECT action_transfer_id
        FROM minka-ach-dw.ach_tin_20200701_1415.action
        WHERE action_type="REJECT" )
    AND 
        transfer_source_bank="Movii"
    AND
        transfer_status="ERROR"
    AND 
        transfer_created>"2020-04-01"