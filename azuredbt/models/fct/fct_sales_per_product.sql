{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN CustomerID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK__fct_sales_per_product__dim_person FOREIGN KEY (CustomerID) REFERENCES dev_dim.dim_person_person(CustomerID)",
    ]
)}}

WITH dim_person AS (SELECT CustomerID
                         , Country
                    FROM dev_dim.dim_person_person),

     dim_salesdetail AS (SELECT SalesOrderID
                              , CustomerID AS cid
                              , LineTotal
                         FROM dev_dim.dim_salesdetail)

SELECT CustomerID
     , SUM(LineTotal) AS SumPerCustomer
FROM dim_person
         LEFT JOIN dim_salesdetail ON dim_person.CustomerID = dim_salesdetail.cid
GROUP BY CustomerID
