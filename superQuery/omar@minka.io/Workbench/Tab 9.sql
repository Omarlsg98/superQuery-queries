SELECT
    *
FROM
    minka-ach-dw.ach_tin.transfer
WHERE 
    source_channel!='"MassTransferCLI"'
    AND created>"2020-04-08"