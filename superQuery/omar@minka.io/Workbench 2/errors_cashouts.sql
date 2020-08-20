SELECT
  transfer_id
  ,action_id
  ,action_type
  ,error_code
  ,action_created
  ,action_hash
FROM `minka-ach-dw.ach_tin.action`
WHERE
  action_type="DOWNLOAD"
  AND action_hash="PENDING"
  AND action_source_bankrouter="$movii"
  AND
  transfer_id IN (
    SELECT
      transfer_id
    FROM
      `minka-ach-dw.temp.movii_no_match`
    WHERE
      analysis LIKE "%cashout%")