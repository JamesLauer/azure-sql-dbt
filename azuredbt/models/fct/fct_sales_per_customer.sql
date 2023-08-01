WITH dim_person AS (SELECT CustomerID
                    FROM dev_dim.dim_person),

     dim_salesdetail AS (SELECT SalesOrderID
                              , CustomerID AS cid
                              , LineTotal
                         FROM dev_dim.dim_salesdetail)

SELECT CustomerID
     , SUM(LineTotal) AS SumPerCustomer
FROM dim_person
         LEFT JOIN dim_salesdetail ON dim_person.CustomerID = dim_salesdetail.cid
GROUP BY CustomerID
