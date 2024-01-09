-- product_snapshot_model.sql
{{ config(
    materialized='snapshot',
    unique_key='cus.id, snapshot_timestamp'
) }}


SELECT
CURRENT_TIMESTAMP() AS snapshot_timestamp,    
cus.id,
cus.last_name,
cus.dob,
cus.first_name, 
d.*
 FROM `{{env_var('DBT_BQ_PROJECT')}}.{{env_var('DBT_BQ_DATASET')}}.customers` cus
join unnest(addresses) as d	
