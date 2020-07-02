SELECT * 
FROM `ach-tin-prd.temp.action_summary`
where ARRAY_LENGTH(status)>1