/*ACTION SUMMARY*/
WITH
grouped_by_error AS
(
    SELECT
      transfer_id,
      type,
      action_status AS status,
      error_code AS code,
      error_message AS message,
      COUNT(*) AS count,
      SUM(IF(action_hash <> 'PENDING', 1, 0)) AS with_hash,
      SUM(IF(action_hash = 'PENDING', 1, 0)) AS without_hash,
      MIN(action_created) AS created,
      MAX(action_udpated) AS updated
    FROM
      minka-ach-dw.temp.action_new_downloads
    GROUP BY
      transfer_id,type,action_status, error_code, error_message
),
grouped_by_status AS
(
    SELECT
      transfer_id,
      type,
      SUM(count) AS count,
      SUM(with_hash) AS with_hash,
      STRUCT(
        status,
        STRUCT(
          SUM(count) AS total,
          SUM(with_hash) AS with_hash,
          SUM(without_hash) AS without_hash
        ) AS count,
        MAX(updated) AS updated,
        ARRAY_AGG(
          STRUCT(
            code,
            message,
            STRUCT(
                count AS total,
                with_hash,
                without_hash
            ) AS count
          )
        ) AS error
      ) AS whole_status,
      MIN(created) AS created,
      MAX(updated) AS updated
    FROM
        grouped_by_error
    GROUP BY
      transfer_id,type,status
)
SELECT
  transfer_id,
  MIN(created) AS created,
  MAX(updated) AS updated,
  type,
  SUM(count) AS count,
  SUM(with_hash) AS with_hash,
  ARRAY_AGG(whole_status) AS status
FROM
    grouped_by_status
GROUP BY
  transfer_id, type
LIMIT 100