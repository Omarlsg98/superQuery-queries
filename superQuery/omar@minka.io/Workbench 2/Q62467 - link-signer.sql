  /*source
-target
-link_id
-created
-signer
 Del signer destino: 
-labels.routerReference

Del wallet asociado al signer destino 
-handle
 
Criterio de filtro:
 Del signer destino, el atributo labels.routerReference = $bancocajasocial
 */
WITH unnest_wallet AS 
(
  SELECT
    u_signer
    ,handle 
  FROM
    `minka-ach-dw.ach_tin.wallet` AS wallet
  CROSS JOIN UNNEST(wallet.signer) AS u_signer
)
 
SELECT
  link_id,
  created,
  source,  
  target,
  signer.labels.routerReference AS target_router_reference,
  wallet.handle AS target_wallet
FROM
  `minka-ach-dw.ach_tin.link` AS link
LEFT JOIN
  `minka-ach-dw.ach_tin.signer` AS signer ON signer.handle=link.target
LEFT JOIN
  unnest_wallet AS wallet ON wallet.u_signer=link.target
WHERE
  signer.labels.routerReference="$bancocajasocial";
/*  
Cordial saludo equipo Minka
Agradezco su apoyo entregando un reporte de relaciones de confianza que contenga los siguientes campos:
link_id	
created	
source	(Wallet)
target	(signer)
target_router_reference	
target_wallet
identification (target_signer)
Filtros:
Desde edl inicio hasta el 11 de sepriembre
target_router_reference = $bancocajasocial */
WITH unnest_wallet AS 
(
  SELECT
    u_signer
    ,handle 
  FROM
    `minka-ach-dw.ach_tin.wallet` AS wallet
  CROSS JOIN UNNEST(wallet.signer) AS u_signer
)
 
SELECT
  link_id,
  created,
  source,  
  target,
  signer.labels.routerReference AS target_router_reference,
  wallet.handle AS target_wallet,
  labels.identification AS target_identification
FROM
  `minka-ach-dw.ach_tin.link` AS link
LEFT JOIN
  `minka-ach-dw.ach_tin.signer` AS signer ON signer.handle=link.target
LEFT JOIN
  unnest_wallet AS wallet ON wallet.u_signer=link.target
WHERE
  signer.labels.routerReference="$bancocajasocial"
  AND link.created BETWEEN "2019-09-13" AND "2020-09-11";