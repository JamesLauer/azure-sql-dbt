WITH cte AS (
    SELECT * FROM raw_sales.salesorderdetail
)
SELECT CAST(SalesOrderID AS int) AS SalesOrderID
      , CAST(SalesOrderDetailID AS int) AS SalesOrderDetailID
      , CAST(CarrierTrackingNumber AS nvarchar) AS CarrierTrackingNumber
      , CAST(OrderQty AS smallint) AS OrderQty
      , CAST(ProductID AS int) AS ProductID
      , CAST(SpecialOfferID AS int) AS SpecialOfferID
      , CAST(UnitPrice AS money) AS UnitPrice
      , CAST(UnitPriceDiscount AS money) AS UnitPriceDiscount
      , CAST(LineTotal AS money) AS LineTotal
      , CAST(rowguid AS uniqueidentifier) AS rowguid
      , CAST(ModifiedDate AS datetime) AS ModifiedDate
FROM cte
