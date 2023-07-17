{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN CustomerID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT customerid_pk_sales_customer PRIMARY KEY (CustomerID)"
    ]
)}}

WITH cte AS (SELECT *
             FROM raw_sales.customer)
SELECT CAST(CustomerID AS int)           AS CustomerID
     , CAST(PersonID AS int)             AS PersonID
     , CAST(StoreID AS int)              AS StoreID
     , CAST(TerritoryID AS int)          AS TerritoryID
     , CAST(AccountNumber AS varchar)    AS AccountNumber
     , CAST(rowguid AS uniqueidentifier) AS rowguid
FROM cte
