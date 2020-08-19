#Calculate signer's balance from Transaction table
CREATE OR REPLACE TABLE `minka-ach-dw.tests.transaction_balance` AS (
WITH summary AS (
  SELECT
    iou.data.source AS signer
    ,- SUM(CAST(iou.data.amount AS FLOAT64)) AS amount
    ,"expend" AS type
  FROM
    `minka-ach-dw.ach_tin.transaction`
  WHERE
    iou.data.symbol="wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC"
  GROUP BY
    iou.data.source
  UNION ALL
  SELECT
    iou.data.target AS signer,
    SUM(CAST(iou.data.amount AS FLOAT64)) AS amount
    ,"income" AS type
  FROM
    `minka-ach-dw.ach_tin.transaction`
  WHERE
    iou.data.symbol="wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC"
  GROUP BY
    iou.data.target
)
SELECT
    signer
    ,SUM(amount) AS balance
FROM
    summary
GROUP BY 
    signer
)