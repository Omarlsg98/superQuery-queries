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
  signer.labels.routerReference="$bancocajasocial"