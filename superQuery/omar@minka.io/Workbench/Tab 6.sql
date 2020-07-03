SELECT
        transfer_source
FROM
    minka-ach-dw.ach_tin_20200701_1415.transfer_action
ORDER BY 
    transfer_created DESC
LIMIT 100