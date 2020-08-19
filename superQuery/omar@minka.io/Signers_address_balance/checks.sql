#Some searchs
SELECT
   iou.data.symbol
FROM 
    `minka-ach-dw.ach_tin.transaction`
GROUP BY
    iou.data.symbol
