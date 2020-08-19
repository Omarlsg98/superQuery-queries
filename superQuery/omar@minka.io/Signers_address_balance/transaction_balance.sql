SELECT
   SUM(CAST(iou.data.amount AS FLOAT64)) 
FROM
    `minka-ach-dw.ach_tin.transaction` AS a
WHERE
    a.iou.data.source="wRxZte3mwBmUbyKBFKMUQc91xZYzXXE4f9"