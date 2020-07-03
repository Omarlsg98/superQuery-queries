SELECT
  COUNT(*)
  ,SUM(if(transfer_id is null,1,0))
FROM
   minka-ach-dw.temp.sql_ds_difference as diff
LEFT JOIN
    minka-ach-dw.ach_tin_20200702_1159.transfer as t
    ON t.transfer_id= diff.action_transfer_id
WHERE
    action_transfer_id IS NOT NULL;
SELECT
  action_type
  ,COUNT(*)
FROM
   minka-ach-dw.temp.sql_ds_difference as diff
LEFT JOIN
    minka-ach-dw.ach_tin_20200702_1159.transfer as t
    ON t.transfer_id= diff.action_transfer_id
WHERE
    transfer_id IS NULL
    AND action_transfer_id IS NOT NULL
GROUP BY
    action_type
