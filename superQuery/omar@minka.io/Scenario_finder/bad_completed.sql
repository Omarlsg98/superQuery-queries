SELECT
    *
FROM
    `minka-ach-dw.ach_tin.pivot_balance_specific_v2` as t
WHERE
    /*Completed sin download en target...*/
    (
        (
            downs_target_signed=0
            AND downs_ambiguous_signed=0
            AND transfer_status="COMPLETED"
        )
        OR
         (
            uploads_signed>0
            AND downs_source_signed=0 
            AND downs_ambiguous_signed=0 
            AND transfer_status="REJECTED"
        )
    )
    AND source_channel!='"MassTransferCLI"'
    AND created>"2020-04-08"