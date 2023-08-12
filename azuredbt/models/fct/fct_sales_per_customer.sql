WITH dim_person AS (SELECT DimPersonID
                         , CustomerID
                         , PersonID
                    FROM dev_dim.dim_person),

     dim_salesdetail AS (SELECT DimSalesDetailID
                              , SalesOrderDetailID
                              , CustomerID AS cid
                              , LineTotal
                         FROM dev_dim.dim_salesdetail),

     dim_address AS (SELECT DimAddressID
                          , AddressID
                          , BusinessEntityID
                     FROM dev_dim.dim_address)

SELECT DimPersonID
     , DimSalesDetailID
     , DimAddressID
     , COUNT(SalesOrderDetailID) AS ItemsOrdered
     , SUM(LineTotal)      AS SumOrderCost
     , AVG(LineTotal)      AS AvgOrderCost
FROM dim_person
         LEFT JOIN dim_salesdetail
                   ON dim_person.CustomerID = dim_salesdetail.cid
         LEFT JOIN dim_address
                   ON dim_person.PersonID = dim_address.BusinessEntityID
GROUP BY DimPersonID, DimSalesDetailID, DimAddressID

