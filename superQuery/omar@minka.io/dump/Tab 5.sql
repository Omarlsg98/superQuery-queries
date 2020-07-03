SELECT 
    error.message.string
FROM 
    ach-tin-prd-multireg.ach_tin_prod_datastore_20200702_1159.action
ORDER BY
    labels.created DESC
LIMIT 150