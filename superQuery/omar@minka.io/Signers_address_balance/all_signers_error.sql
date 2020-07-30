SELECT
    source_signer
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    source_signer IS NOT NULL
    AND status NOT IN ("COMPLETED")
UNION DISTINCT
SELECT
    target_signer
FROM
    minka-ach-dw.ach_tin.transfer
WHERE
    target_signer IS NOT NULL
    AND status NOT IN ("COMPLETED")