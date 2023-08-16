SELECT   
cus.id,
cus.last_name,
cus.dob,
cus.first_name, 
d.*
 FROM `test-bi-query-291307.dbt_demo_bigquery.customers` cus
join unnest(addresses) as d	
