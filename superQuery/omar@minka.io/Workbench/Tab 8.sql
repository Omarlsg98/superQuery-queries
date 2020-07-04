SELECT
    *
FROM 
    minka-ach-dw.movii_bridge_log.ach_bank_review
WHERE 
    transfer_id NOT IN (
                    SELECT
                        transfer_id
                    FROM
                        minka-ach-dw.movii_bridge_log.movii_status_200702
                    GROUP BY
                        transfer_id
                    HAVING 
                        COUNT(*)>1)