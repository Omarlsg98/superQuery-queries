WITH min_by_type AS (
  SELECT
    transfer_id
    ,CAST(MIN(IF(type="UPLOAD",SUBSTR(action_created,1,19),NULL)) AS DATETIME) AS min_created_upload
    ,CAST(MIN(IF(type="DOWNLOAD_SOURCE",SUBSTR(action_created,1,19),NULL)) AS DATETIME) AS min_created_download
  FROM `minka-ach-dw.temp.action_new_downloads`
  WHERE
    transfer_id IN (
    SELECT
      transfer_id
    FROM
      `minka-ach-dw.temp.movii_match`
    WHERE
      analysis LIKE "%cashout%"
    )
  GROUP BY
    transfer_id
 )
SELECT
  transfer_id
  ,DATETIME_DIFF(min_created_upload, min_created_download, SECOND) AS diff_time_up_dw
FROM
  min_by_type
ORDER BY 
  transfer_id