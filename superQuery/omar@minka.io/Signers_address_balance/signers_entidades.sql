SELECT
    action_source_signer
    ,action_source_bankrouter
FROM
    minka-ach-dw.ach_tin.action
WHERE
    action_type="UPLOAD"
GROUP BY
    action_source_signer
    ,action_source_bankrouter