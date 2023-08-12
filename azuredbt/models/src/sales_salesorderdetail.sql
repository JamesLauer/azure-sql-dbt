{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN SalesOrderDetailID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_SalesOrderDetailID PRIMARY KEY (SalesOrderDetailID)",
    ]
)}}


WITH cte AS (SELECT *
             FROM dev_raw.sales_salesorderdetail)
SELECT CAST(SalesOrderID AS int)               AS SalesOrderID
     , CAST(SalesOrderDetailID AS int)         AS SalesOrderDetailID
     , CAST(CarrierTrackingNumber AS nvarchar) AS CarrierTrackingNumber
     , CAST(OrderQty AS smallint)              AS OrderQty
     , CAST(ProductID AS int)                  AS ProductID
     , CAST(SpecialOfferID AS int)             AS SpecialOfferID
     , CAST(UnitPrice AS money)                AS UnitPrice
     , CAST(UnitPriceDiscount AS money)        AS UnitPriceDiscount
     , CAST(LineTotal AS money)                AS LineTotal
     , CAST(rowguid AS uniqueidentifier)       AS rowguid
     , CAST(ModifiedDate AS datetime)     AS ModifiedDate
FROM cte
