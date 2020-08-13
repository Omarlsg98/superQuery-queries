/*TX N ACTIONS*/

SELECT
  * EXCEPT(error_code, error_message),
  STRUCT(error_code AS code, error_message AS message) AS error,
  (
    SELECT
      STRUCT(created, updated, count,with_hash, status)
    FROM
      minka-ach-dw.temp.action_summary asum
    WHERE
      t.transfer_id = asum.transfer_id
      AND (
        asum.type = "SEND"
        or asum.type = "REQUEST"
      )
  ) AS main_action,
  (
    SELECT
      STRUCT(created, updated, count,with_hash, status)
    FROM
      minka-ach-dw.temp.action_summary asum
    WHERE
      t.transfer_id = asum.transfer_id
      AND asum.type = "UPLOAD"
  ) AS upload,
  (
    SELECT
      STRUCT(created, updated, IFNULL(count,0) AS count, IFNULL(with_hash,0) AS with_hash, status)
    FROM
      minka-ach-dw.temp.action_summary asum
    WHERE
      t.transfer_id = asum.transfer_id
      AND asum.type = "DOWNLOAD_TARGET"
  ) AS download_target,
  (
    SELECT
      STRUCT(created, updated, count,with_hash, status)
    FROM
      minka-ach-dw.temp.action_summary asum
    WHERE
      t.transfer_id = asum.transfer_id
      AND asum.type = "REJECT"
  ) AS reject,
  (
    SELECT
      STRUCT(created, updated, count,with_hash, status)
    FROM
      minka-ach-dw.temp.action_summary asum
    WHERE
      t.transfer_id = asum.transfer_id
      AND asum.type = "DOWNLOAD_SOURCE"
  ) AS download_source,
  (
    SELECT
      STRUCT(created, updated, count,with_hash, status)
    FROM
      minka-ach-dw.temp.action_summary asum
    WHERE
      t.transfer_id = asum.transfer_id
      AND asum.type = "DOWNLOAD_AMBIGUOUS"
  ) AS download_ambiguous 
FROM
  minka-ach-dw.ach_tin.transfer t
LIMIT 100