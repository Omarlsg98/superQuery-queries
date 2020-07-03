SELECT
  *
FROM
     EXTERNAL_QUERY("us-east4.ach_tin_prd",
                  '''select action_id,transferId,type,status,labels->"$.hash"as firma,
                            	created , updated,amount,sourceWallet, targetWallet , sourceBank, targetBank,error->"$.code" as code,
                            	error->"$.message" as message ,
                            	labels->"$.sourceChannel"  as channel, sourceSigner, targetSigner , snapshot , sourceBankBicfi ,targetBankBicfi 
                            From action
                            where  transferId IN ('oRR06jChdkE887ciu')
                            Order by created ''')