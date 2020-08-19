#Get the last movements by signer and position (source/target)
#wRxZte3mwBmUbyKBFKMUQc91xZYzXXE4f9
WITH summary AS (
  SELECT
    iou.data.source AS signer
    ,- SUM(CAST(iou.data.amount AS FLOAT64)) AS amount
    ,"expend" AS type
  FROM
    `minka-ach-dw.ach_tin.transaction` AS a
  GROUP BY
    iou.data.source
  UNION ALL
  SELECT
    iou.data.target AS signer,
    SUM(CAST(iou.data.amount AS FLOAT64)) AS amount
    ,"income" AS type
  FROM
    `minka-ach-dw.ach_tin.transaction` AS a
  GROUP BY
    iou.data.target
)
SELECT
    COUNT(signer)
    
FROM
    summary