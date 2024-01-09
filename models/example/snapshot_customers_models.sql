{% snapshot users_snapshot %}  
--  In this strategy, dbt will create a new snapshot record whenever the timestamp column is more recent than the last time the snapshot was run
-- for TEST  virtual timestamp value created each time a RUN 
{{ config(
   target_schema='snapshots',      
    strategy='timestamp',      
    unique_key='cus.id',      
    updated_at='snapshot_timestamp'
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

    {% endsnapshot %}
