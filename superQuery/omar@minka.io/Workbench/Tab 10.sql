 SELECT 
        string_field_7
      , count(*)
FROM
    `minka-ach-dw.movii_bridge_log.movii_logs_20_07_09`
GROUP BY
    string_field_7