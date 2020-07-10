SELECT 
    *
FROM
    minka-ach-dw.ach_tin.action
WHERE
    action_type IN ("DOWNLOAD", "UPLOAD")
    AND (action_source_signer="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2" 
        OR action_target_signer="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2")