SELECT tp1.* , tp2.* EXCEPT (id , status)  
 FROM {{ ref('customers_type1_merge') }} tp1
 INNER JOIN
 {{ ref('snapshot_customers_type2') }} tp2
 ON  tp1.id = tp2.id  AND  tp1.status = tp2.status

