-- product_snapshot_model.sql
{{ config(
    materialized='snapshot',
    unique_key='product_id, snapshot_timestamp'
) }}

SELECT
  CURRENT_TIMESTAMP() AS snapshot_timestamp,
  product_id,
  product_name,
  inventory_count
FROM
  {{ ref('products') }}
