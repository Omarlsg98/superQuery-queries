SELECT
    omar.action_id AS manual
    ,julian.action_id AS dataflow
    , omar.labels.created AS action_created
    , omar.labels.updated AS action_udpated
    , julian.labels.created AS jul_action_created
    , julian.labels.updated AS jul_action_udpated
FROM 
    ach-tin-prd-multireg.ach_tin_prod_datastore.action AS omar
FULL JOIN 
    ach-tin-prd-multireg.datastore_to_bigquery.action AS julian
        ON omar.action_id=julian.action_id
WHERE 
    (omar.action_id IS NULL
    OR julian.action_id IS NULL)
    AND julian.labels.created < "2020-07-23T09:06:09"
LIMIT 100