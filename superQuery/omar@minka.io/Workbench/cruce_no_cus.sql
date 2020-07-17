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
    ,p.cellphone
    ,source_wallet
    ,status
    ,t.amount
FROM
    minka-ach-dw.movii_bridge_log.avvillas_manual_change AS p
LEFT JOIN
     only_avvillas AS t ON p.date=CAST(SUBSTR(t.created,1,10) AS DATE) AND p._amount_=t.amount AND CONCAT("$",p.cellphone)=t.source_wallet