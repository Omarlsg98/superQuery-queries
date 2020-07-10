 SELECT 
       count(*)
FROM
    `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09`
WHERE
    string_field_7="TD"