SELECT
  count(*)
FROM
    minka-ach-dw.ach_tin_20200701_1415.transfer_one_action_error
WHERE
    transfer_error_code NOT IN ('120','300')