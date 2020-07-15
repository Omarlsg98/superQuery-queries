SELECT
    COUNT(*)
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    transfer_id IN (
        SELECT
            transfer_id
        FROM
            minka-ach-dw.ach_tin.action
        WHERE
            action_type="UPLOAD" AND action_status ="COMPLETED")
    AND
     transfer_id IN (
        SELECT
            transfer_id
        FROM
            minka-ach-dw.ach_tin.action
        WHERE
            action_type="DOWNLOAD" AND action_status !="COMPLETED")
    AND 
        source_bank="Movii"
    AND 
        created BETWEEN "2020-04-01" AND "2020-07-06"