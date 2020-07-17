CREATE TABLE  minka-ach-dw.movii_bridge_log.avvillas_manual_change_v2 AS 
(
SELECT
    * EXCEPT(cellphone,time)
    , IF(LENGTH(CAST(time AS STRING))<8, CONCAT("0",time),CAST(time AS STRING)) AS time
    ,CONCAT("$",cellphone) AS cellphone
FROM
    minka-ach-dw.movii_bridge_log.avvillas_manual_change
)