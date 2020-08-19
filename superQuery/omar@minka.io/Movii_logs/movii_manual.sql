SELECT
        manual.* 
        ,normal.transfer_id AS n_transfer_id
        ,normal.cell_id AS n_cell_id
        ,normal.msisdn AS n_misisdn
        ,normal.value AS n_value
        ,normal.transfer_on AS n_transfer_on
        ,IFNULL(normal.cell_id,manual.related_cus) AS cell_id
    FROM
        minka-ach-dw.movii_bridge_log.movii_manual_adjustments AS manual
    LEFT JOIN
        minka-ach-dw.movii_bridge_log.movii_logs_all AS normal
            ON LOWER(normal.transfer_id)=LOWER(manual.related_transfer_id)