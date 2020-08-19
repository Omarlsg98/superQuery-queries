#Get the last movements by signer and position (source/target)
SELECT
   SUM(iou.data.amount) 
FROM
    `minka-ach-dw.ach_tin.transaction` AS a
WHERE
    AND a.iou.data.source="wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC"