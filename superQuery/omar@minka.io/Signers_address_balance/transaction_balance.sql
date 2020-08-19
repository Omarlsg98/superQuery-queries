#Get the last movements by signer and position (source/target)
SELECT
    iou.data.source
    ,MAX(created)
FROM
    `minka-ach-dw.ach_tin.transaction` AS a
LEFT JOIN
     `minka-ach-dw.ach_tin.transaction` AS b
        ON a.iou.data.source=b.iou.data.source
            AND a.created<b.created
WHERE
    b.iou.data.source IS NULL
    AND a.iou.data.source="wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC"