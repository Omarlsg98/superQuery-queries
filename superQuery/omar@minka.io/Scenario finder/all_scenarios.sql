/*---------------ALL SCENARIES--------------------*/
select "1.1 no download_t created" as description,target_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count is null  and  download_source.count is null and reject.count is null and download_ambiguous.count is null 
  and
  EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED")) 
  and
  EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("COMPLETED")) 
  and
    status="ERROR"
  and created BETWEEN "2020-04-08" and "2020-06-26"	
group by bank,error.code
UNION ALL
select "1.2 no download_t sign" as description,target_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count=1 and  download_source.count is null and reject.count is null and download_ambiguous.count is null 
  and
  EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED")) 
  and
  EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("COMPLETED")) 
  and
  EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("PENDING")) 
  and
    status="ACCEPTED"
  and created BETWEEN "2020-04-08" and "2020-06-26"	
group by bank,error.code
UNION ALL
select "1.3 non-reverse error in download_t" as description,target_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count=1 and  download_source.count is null and reject.count is null and download_ambiguous.count is null 
  and
  EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED")) 
  and
  EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("COMPLETED")) 
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR") and not
            EXISTS ( SELECT 1 FROM UNNEST(error) WHERE code  IN ("303","304","306","307","308","309","310","311","312","313","314","315","316","319","322","329","332") ))
  and
    status="ERROR"
  and created BETWEEN "2020-04-08" and "2020-06-26"	
group by bank,error.code
UNION ALL
select "1.4 no continue in download_t" as description,target_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count=1 and  download_source.count is null and reject.count is null and download_ambiguous.count is null 
  and
  EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED")) 
  and
  EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("COMPLETED")) 
  and
  EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("COMPLETED")) 
  and
    status="ACCEPTED"
  and created BETWEEN "2020-04-08" and "2020-06-26"	
group by bank,error.code
UNION ALL
select "2.1 reverse error in download_t" as description,target_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count>=1
  and
	EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED"))
  and
	EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("REJECTED")) 
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR") and 
            EXISTS ( SELECT 1 FROM UNNEST(error) WHERE code IN ("303","304","306","307","308","309","310","311","312","313","314","315","316","319","322","329","332") ))
  and created BETWEEN "2020-04-08" and "2020-06-26"	
group by bank,error.code
UNION ALL
select "3.1 error in reject " as description,target_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count>=1 and reject.count>=1
  and
	EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED"))
  and
	EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("REJECTED")) 
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR") and 
            EXISTS ( SELECT 1 FROM UNNEST(error) WHERE code IN ("303","304","306","307","308","309","310","311","312","313","314","315","316","319","322","329","332") ))
  and
	NOT EXISTS ( SELECT 1 FROM UNNEST(reject.status) WHERE status IN ("COMPLETED"))
 and created BETWEEN "2020-04-08" and "2020-06-26"	
group by bank,error.code
UNION ALL
select "4.1 no download_s created" as description,source_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count>=1 and reject.count>=1 and download_source is null
  and
	EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED"))
  and
	EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("REJECTED")) 
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR") and 
            EXISTS ( SELECT 1 FROM UNNEST(error) WHERE code IN ("303","304","306","307","308","309","310","311","312","313","314","315","316","319","322","329","332") ))
  and
	EXISTS ( SELECT 1 FROM UNNEST(reject.status) WHERE status IN ("COMPLETED"))
  and
    status="ERROR"
 and created BETWEEN "2020-04-08" and "2020-06-26"	
group by bank,error.code
UNION ALL
select "4.2 download_s no sign" as description,source_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count>=1 and reject.count>=1 and download_source.count=1
  and
	EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED"))
  and
	EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("REJECTED")) 
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR") and 
            EXISTS ( SELECT 1 FROM UNNEST(error) WHERE code IN ("303","304","306","307","308","309","310","311","312","313","314","315","316","319","322","329","332") ))
  and
	EXISTS ( SELECT 1 FROM UNNEST(reject.status) WHERE status IN ("COMPLETED"))
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_source.status) WHERE status IN ("PENDING"))
  and
    status="ERROR"
 and created BETWEEN "2020-04-08" and "2020-06-26"
group by bank,error.code
UNION ALL
select "4.3 download_s error" as description,source_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count>=1 and reject.count>=1 and download_source.count>=1
  and
	EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED"))
  and
	EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("REJECTED")) 
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR") and 
            EXISTS ( SELECT 1 FROM UNNEST(error) WHERE code IN ("303","304","306","307","308","309","310","311","312","313","314","315","316","319","322","329","332") ))
  and
	EXISTS ( SELECT 1 FROM UNNEST(reject.status) WHERE status IN ("COMPLETED"))
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_source.status) WHERE status IN ("ERROR"))
  and 
   NOT EXISTS ( SELECT 1 FROM UNNEST(download_source.status) WHERE status IN ("COMPLETED"))
  and
    status="ERROR"
 and created BETWEEN "2020-04-08" and "2020-06-26"
group by bank,error.code
UNION ALL
select "4.4 download_s no continue" as description,source_bank as bank,error.code, count(*) as cases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count>=1 and reject.count>=1 and download_source.count>=1
  and
	EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED"))
  and
	EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("REJECTED")) 
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR") and 
            EXISTS ( SELECT 1 FROM UNNEST(error) WHERE code IN ("303","304","306","307","308","309","310","311","312","313","314","315","316","319","322","329","332") ))
  and
	EXISTS ( SELECT 1 FROM UNNEST(reject.status) WHERE status IN ("COMPLETED"))
  and 
    EXISTS ( SELECT 1 FROM UNNEST(download_source.status) WHERE status IN ("COMPLETED"))
  and
    status="ERROR"
 and created BETWEEN "2020-04-08" and "2020-06-26"
group by bank,error.code
UNION ALL
select "5.0 no errors in reverse" as description,source_bank as bank,error.code, count(*) as Ncases
from temp.tx_n_actions
where  upload.count=1 and  main_action.count=1 and  download_target.count>=1  and  download_source.count>=1 and reject.count>=1 and download_ambiguous.count is null 
  and
  EXISTS ( SELECT 1 FROM UNNEST(upload.status) WHERE status IN ("COMPLETED")) 
   and
	EXISTS ( SELECT 1 FROM UNNEST(main_action.status) WHERE status IN ("REJECTED")) 
  and 
   EXISTS ( SELECT 1 FROM UNNEST(download_target.status) WHERE status IN ("ERROR") and 
            EXISTS ( SELECT 1 FROM UNNEST(error) WHERE code IN ("303","304","306","307","308","309","310","311","312","313","314","315","316","319","322","329","332") ))
  and
	EXISTS ( SELECT 1 FROM UNNEST(reject.status) WHERE status IN ("COMPLETED"))
  and 
   EXISTS ( SELECT 1 FROM UNNEST( download_source.status) WHERE status IN ("COMPLETED"))
  and
    status="REJECTED"
  and created BETWEEN "2020-04-08" and "2020-06-26"
group by source_bank,error.code
order by description ASC, cases DESC