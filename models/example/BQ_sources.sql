select * from `{{ source('test-bi-query-291307', 'Sales.FactSales_partitioned') }}`