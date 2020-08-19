#Calculate signer's balance from Transaction table
CREATE OR REPLACE TABLE `minka-ach-dw.tests.transaction_balance` AS (
WITH transaction_fix AS (
    SELECT
        iou.data.source AS source
        ,iou.data.target AS target
        ,CAST(iou.data.amount AS FLOAT64) AS amount
    FROM
        `minka-ach-dw.ach_tin.transaction`
    WHERE
         iou.data.symbol="wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC"
    UNION ALL
    #Actions with hash that are not present in transaction
    SELECT
        action_source_signer AS source
        ,action_target_signer AS target
        ,CAST(action_amount AS FLOAT64) AS amount
    FROM
        `minka-ach-dw.ach_tin.transaction`
    FULL JOIN
        `minka-ach-dw.ach_tin.action`
            ON action_hash=iou.hash.value
    WHERE
        (transaction_id IS NULL
            AND action_hash IS NOT NULL 
            AND action_hash 
                NOT IN("PENDING","ERROR","COMPLETED","ACCEPTED","REJECTED","INITIATED")
        )
),
summary AS (
#Sum expends
  SELECT
    source AS signer
    ,- SUM(amount) AS amount
  FROM
    transaction_fix
  GROUP BY
    source
  UNION ALL
#Sum incomes
  SELECT
    target AS signer,
    SUM(amount) AS amount
  FROM
    transaction_fix
  GROUP BY
    target
)
SELECT
    signer
    ,SUM(amount) AS balance
FROM
    summary
GROUP BY 
    signer
)