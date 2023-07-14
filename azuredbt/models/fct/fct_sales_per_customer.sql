WITH dim_person AS (
    SELECT BusinessEntityID
    FROM dev_dim.person_person
),

dim_address AS (
    SELECT BusinessEntityID AS address_beid
        , AddressID
    FROM dev_dim.person_address
),

dim_salesdetail AS (
    SELECT SalesOrderID
        , CustomerID
        , TotalDuePerOrder
    FROM dev_dim.person_salesdetail
)


SELECT BusinessEntityID
, AddressID
, SalesOrderID
, SUM(TotalDuePerOrder) AS SumPerCustomer
FROM dim_person
LEFT JOIN dim_address on dim_person.BusinessEntityID = dim_address.address_beid
LEFT JOIN dim_salesdetail on dim_address.address_beid = dim_salesdetail.CustomerID
ORDER BY SumPerCustomer DESC
