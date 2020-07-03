SELECT
  STRING_AGG(action_transfer_id,"','")
FROM
   minka-ach-dw.temp.sql_ds_difference