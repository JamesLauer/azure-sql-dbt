WITH dim_person AS (SELECT CustomerID
                    , Name
                    , City
                    , PostalCode
                    FROM dev_dim.dim_person_person),

     dim_salesdetail AS (SELECT SalesOrderID
                              , CustomerID AS cid
                              , LineTotal
                         FROM dev_dim.dim_salesdetail)

SELECT CustomerID
     , City
     , PostalCode
     , SUM(LineTotal) AS SumPerCustomer
FROM dim_person
         LEFT JOIN dim_salesdetail ON dim_person.CustomerID = dim_salesdetail.cid
GROUP BY CustomerID, City, PostalCode
