SELECT
    *
FROM
    minka-ach-dw.ach_tin.transaction
WHERE
    iou.data.source="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2" OR iou.data.target="wVCmBRk2jz5fBi47kpzGZezoovzfudv6L2"
LIMIT 100