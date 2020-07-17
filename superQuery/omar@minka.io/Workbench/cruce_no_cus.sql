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
    ARRAY_AGG(
        STRUCT(
            transfer_id
            ,created
            ,source_bank
            ,source_wallet
            ,status
            ,t.amount
        ) ) AS transfers 
    ,p.date
    ,p.time
    ,action
    ,p.cellphone
    ,_amount_
FROM
    minka-ach-dw.movii_bridge_log.avvillas_manual_change_v2 AS p
LEFT JOIN
     only_avvillas AS t ON p.date=CAST(SUBSTR(t.created,1,10) AS DATE) AND p._amount_=t.amount
        AND p.cellphone=t.source_wallet AND SUBSTR(p.time,1,2)=SUBSTR(t.created,12,2)
GROUP BY date,time,cellphone,_amount_,action