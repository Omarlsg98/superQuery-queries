SELECT
   *
FROM
    `minka-ach-dw.ach_tin.transaction` AS a
WHERE
    a.iou.data.source="wd7VoAD3PzRdRRuKUbSUzL2gFgSD4Z8HRC"
    AND iou.data.amount="20"