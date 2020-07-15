SELECT
  *
FROM
    minka-ach-dw.ach_tin.transfer
WHERE 
    source_channel!='"MassTransferCLI"'
    AND created BETWEEN "2020-04-08" AND "2020-07-09"
    AND status NOT IN ("COMPLETED","REJECTED")