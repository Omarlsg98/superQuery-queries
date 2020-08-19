SELECT
   iou.data.symbol
FROM 
    `minka-ach-dw.ach_tin.transaction`
 WHERE
    iou.data.symbol="wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC"
GROUP BY
    iou.data.symbol