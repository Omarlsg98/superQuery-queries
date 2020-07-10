 CREATE TABLE minka-ach-dw.movii_bridge_log.movii_logs_20_07_09_gc AS
 SELECT 
     CELL_ID AS cell_id
     ,TRANSFER_ID AS transfer_id
     ,MSISDN AS cellphone
     ,ERROR_CODE AS amount
     ,TRANSFER_STATUS AS error_code
     ,string_field_7 AS transfer_status
FROM
    `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09`