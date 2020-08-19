#Add cell_ids to movii_manual
CREATE OR REPLACE TABLE minka-ach-dw.movii_bridge_log.movii_manual_ids AS (
    SELECT
        * 
        ,IFNULL(manual.related_cus,normal.cell_id) AS cell_id
    FROM
        minka-ach-dw.movii_bridge_log.movii_manual_adjustments AS manual
    LEFT JOIN
        minka-ach-dw.movii_bridge_log.movii_logs_all AS normal
            ON LOWER(normal.transfer_id)=LOWER(manual.related_transfer_id)
)