SELECT
    ds.action_id as ds_id
    ,action_type
    ,ds.action_transfer_id
    ,sql.action_id as sql_id
    ,ds.action_created
FROM 
    minka-ach-dw.ach_tin_20200702_1159.action AS ds
FULL JOIN
    ach-tin-prd.sql_dump.action as sql
        ON ds.action_id=sql.action_id
WHERE 
     (ds.action_id IS NULL
     OR sql.action_id IS NULL)
     AND ds.action_created<"2020-07"