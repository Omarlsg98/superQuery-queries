#Lost IOUs 
SELECT
    *
FROM
    minka-ach-dw.ach_tin.transaction
WHERE
    iou.data.source="wfKKKwyEnVT83AcRMcnjTEdhx68LwWLddS" OR iou.data.target="wfKKKwyEnVT83AcRMcnjTEdhx68LwWLddS"
LIMIT 100