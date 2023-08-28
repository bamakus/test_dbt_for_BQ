select * from {{ source('test-bi-query-291307', 'FactSales_partitioned') }}	
