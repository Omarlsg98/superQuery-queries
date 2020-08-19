#Get the last movements by signer and position (source/target)
SELECT
   SUM(CAST(iou.data.amount AS FLOAT64)) 
FROM
    `minka-ach-dw.ach_tin.transaction` AS a
WHERE
    a.iou.data.source="wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC"