--Write Once, Run Anywhere
SELECT   
cus.id,
cus.last_name,
cus.dob,
cus.first_name, 
d.*
 FROM `{{env_var('DBT_BQ_PROJECT')}}.{{env_var('DBT_BQ_DATASET')}}` cus
join unnest(addresses) as d	
