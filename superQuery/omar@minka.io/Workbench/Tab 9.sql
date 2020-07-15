SELECT
    source_channel
FROM
    minka-ach-dw.ach_tin.transfer
GROUP BY 
    source_channel