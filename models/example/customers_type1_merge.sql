{{
    config(
        materialized='incremental',         
        unique_key="PK", 
        strategy = "merge" 
    )
}}

SELECT
cus.id||'-'||d.status as PK,  
cus.id,
cus.dob,
cus.last_name, 
d.*
 FROM `test-bi-query-291307.dbt_demo_bigquery.customers` cus
join unnest(addresses) as d


{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records arriving later on the same day as the last run of this model)
  --where date_day >= (select max(date_day) from {{ this }})

{% endif %}


	
