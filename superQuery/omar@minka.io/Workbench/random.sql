SELECT
    COUNT(action_id)
FROM 
    minka-ach-dw.ach_tin.transfer
INNER JOIN
    minka-ach-dw.ach_tin.action
        ON action.transfer_id=transfer.transfer_id
WHERE
    action.action_type IN ("REQUEST","SEND")
    AND (transfer.source_signer!=action_source_signer
        OR transfer.target_signer!=action_target_signer )