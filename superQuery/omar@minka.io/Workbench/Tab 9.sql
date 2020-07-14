SELECT
    action_source_bankname AS bank
    ,error_code
    ,error_message
    ,count(transfer_id) as number
FROM
    minka-ach-dw.ach_tin.action
WHERE
    action_source_bankname IS NOT NULL 
    AND action_source_bankname NOT IN ("Atenea","Zeus")
GROUP BY
    error_code
    ,error_message
    ,action_source_bankname
ORDER BY
    bank ASC
    , number DESC