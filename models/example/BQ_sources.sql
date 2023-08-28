select * from {{ source('big_sales', 'Sales.FactSales_partitioned') }}	
