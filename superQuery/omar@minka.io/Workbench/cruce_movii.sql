CREATE TABLE  movii_transfer_200704_1630  AS
(
SELECT
    t.transfer_id
    ,t.tx_id AS transfer_tx_id
    ,movii.tx_id AS movii_tx_id
   ,* EXCEPT(transfer_id,tx_id)
FROM
    minka-ach-dw.movii_bridge_log.movii_status_200702 AS movii
INNER JOIN 
    minka-ach-dw.ach_tin_20200704_1630.transfer AS t
        ON UPPER(t.transfer_id)=movii.transfer_id
)