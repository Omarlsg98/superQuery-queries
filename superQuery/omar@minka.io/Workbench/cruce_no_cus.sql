WITH only_avvillas AS(
SELECT
    transfer_id
    ,created
    ,source_bank
    ,source_wallet
    ,status
    ,t.amount
FROM
    minka-ach-dw.ach_tin.transfer AS t
WHERE 
    source_bank="Banco AV Villas"
)
SELECT
    transfer_id
    ,created
    ,source_bank
    ,source_wallet
    ,status
    ,t.amount
FROM
    only_avvillas AS t
INNER JOIN
    minka-ach-dw.temp.prueba AS p ON p.date=CAST(SUBSTR(t.created,1,10) AS DATE) AND p.amount=t.amount AND p.cel_origen=t.source_wallet