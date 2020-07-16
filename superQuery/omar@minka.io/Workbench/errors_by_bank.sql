SELECT
    action_source_bankrouter AS bank
    ,CASE
        WHEN action_type="UPLOAD" THEN "debit"
        WHEN action_type="DOWNLOAD" THEN "credit"
        WHEN action_type IN ("SEND","REQUEST","REJECT") THEN "action"
    END AS endpoint_involved
    ,error_code
    ,error_message
    ,count(transfer_id) as number
FROM
    minka-ach-dw.ach_tin.action
WHERE
    action_source_bankrouter IS NOT NULL 
    AND (
        (action_type="REJECT" AND action_status="ERROR")
        OR NOT (action_type IN ("SEND","REQUEST") AND action_status="REJECTED" AND action_hash<> 'PENDING')
    )
GROUP BY
    error_code
    ,error_message
    ,action_source_bankrouter
    ,endpoint_involved
ORDER BY
    bank ASC
    , number DESC