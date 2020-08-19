SELECT
    *
FROM
    minka-ach-dw.ach_tin.action
WHERE
    action_target_signer IN ( "wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC", #TIN signer
                            "wXmZi7xP4x2kyTjXH55EyWQSczvrLRfHL5") #ACH signer
    OR
    action_source_signer IN ( "wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC")