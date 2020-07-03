SELECT
   count(transfer_id)
FROM
    minka-ach-dw.temp.tx_n_actions as t
WHERE
    upload.count is null 
    AND main_action.count=1 
    AND download_target.count is null 
    AND download_source.count is null
    AND reject.count is null 
    AND download_ambiguous.count is null
    AND created BETWEEN "2020-04-01" AND "2020-06-30"
    AND source_channel!='"MassTransferCLI"'
    AND EXISTS (SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("ERROR")) 
    AND status="ERROR"