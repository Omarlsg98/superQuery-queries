SELECT
   COUNT(*)
FROM 
    minka-ach-dw.movii_bridge_log.movii_match_20_07_08 AS match
LEFT JOIN 
    minka-ach-dw.ach_tin.transfer
     ON transfer.transfer_id=match.movii_transfer_id
WHERE
    UPPER(transfer_id) IN (
    SELECT transfer_id
    FROM minka-ach-dw.movii_bridge_log.movii_diferencia_05_07_2020)