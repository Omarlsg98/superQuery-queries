SELECT 
   action_type
   ,action_status
   ,COUNT(action_id) AS conteo
   ,MAX(action_created) AS fecha_maxima_registra
   ,MIN(action_created) AS fecha_minima
FROM
    minka-ach-dw.ach_tin.action
GROUP BY
    action_type
    ,action_status