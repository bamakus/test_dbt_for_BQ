--  In this strategy, dbt will create a new snapshot record whenever the timestamp column is more recent than the last time the snapshot was run
-- for TEST  virtual timestamp value created each time a RUN 
{% snapshot snapshot_customers %}
{{ config(
    materialized='snapshot',
    target_schema='dbt_demo_bigquery',
    strategy='check',      
    unique_key="id||'-'||status",     
    check_cols=['numberOfYears']
    ) }}

-- Pro-Tip: Use sources in snapshots!
SELECT
CURRENT_TIMESTAMP() AS snapshot_timestamp,    
cus.id,
cus.last_name,
cus.dob,
cus.first_name,
cus.numberOfYears, 
d.*
 FROM `{{env_var('DBT_BQ_PROJECT')}}.{{env_var('DBT_BQ_DATASET')}}.customers` cus
join unnest(addresses) as d	
{% endsnapshot %}
