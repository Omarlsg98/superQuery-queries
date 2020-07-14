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
            type="UPLOAD" AND status ="COMPLETED")
    AND
     transfer_id IN (
        SELECT
            transfer_id
        FROM
            minka-ach-dw.ach_tin.action
        WHERE
            type="DOWNLOAD" AND status !="COMPLETED")