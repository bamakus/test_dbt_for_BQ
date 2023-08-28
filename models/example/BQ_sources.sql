select * from {{ source('big_sales', 'FactSales_partitioned') }}	
