 SELECT
                        transfer_id
                    FROM
                        minka-ach-dw.movii_bridge_log.movii_status_200702
                    GROUP BY
                        transfer_id
                    HAVING 
                        COUNT(*)>1