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
    ,p.date
    ,p.time
    ,source_bank
    ,p.cel_origen
    ,source_wallet
    ,status
    ,t.amount
FROM
    minka-ach-dw.temp.prueba AS p
LEFT JOIN
     only_avvillas AS t ON p.date=CAST(SUBSTR(t.created,1,10) AS DATE) AND p.amount=t.amount AND p.cel_origen=t.source_wallet