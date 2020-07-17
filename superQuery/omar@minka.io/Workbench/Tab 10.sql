SELECT
    * EXCEPT(cellphone,time)
    , CAST(IF(LENGTH(CAST(time AS STRING))<8, CONCAT("0",time),CAST(time AS STRING)) AS TIME) AS time
    ,CONCAT("$",cellphone) AS cellphone
FROM
    minka-ach-dw.movii_bridge_log.avvillas_manual_change