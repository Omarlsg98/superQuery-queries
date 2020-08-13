SELECT
    *
FROM
    `minka-ach-dw.ach_tin.pivot_balance_specific_v2` as t
WHERE
    (
        uploads_signed=0
        OR main_actions_signed=0
        OR downs_target_signed=0
    )
    AND transfer_status="COMPLETED"
    AND source_channel!='"MassTransferCLI"'