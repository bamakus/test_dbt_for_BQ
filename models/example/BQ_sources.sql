select * from {{ source('bigquery', 'FactSales') }}
