SELECT
    action_source_bankname
    ,error_code
    ,error_message
    ,count(transfer_id)
FROM
    minka-ach-dw.ach_tin.action
GROUP BY
    error_code
    ,error_message
    ,action_source_bankname