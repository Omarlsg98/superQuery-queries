SELECT
    status
    ,COUNT(transfer_id)
FROM
    minka-ach-dw.ach_tin_before.transfer_20200701_1415
WHERE 
    source_channel!='"MassTransferCLI"'
    AND created BETWEEN "2020-04-08" AND "2020-07-09"
GROUP BY
    status