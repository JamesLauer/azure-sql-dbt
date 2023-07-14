{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN SalesOrderID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT sales_salesorderheader_pk PRIMARY KEY (SalesOrderID)"
    ]
)}}

WITH cte AS (
    SELECT * FROM raw_sales.salesorderheader
)
SELECT CAST(SalesOrderID AS int) AS SalesOrderID
      , CAST(RevisionNumber AS tinyint) AS RevisionNumber
      , CAST(OrderDate AS datetime) AS OrderDate
      , CAST(DueDate AS datetime) AS DueDate
      , CAST(ShipDate AS datetime) AS ShipDate
      , CAST(Status AS tinyint) AS Status
      , CAST(OnlineOrderFlag AS bit) AS OnlineOrderFlag
      , CAST(SalesOrderNumber AS nvarchar) AS SalesOrderNumber
      , CAST(PurchaseOrderNumber AS nvarchar) AS PurchaseOrderNumber
      , CAST(AccountNumber AS nvarchar) AS AccountNumber
      , CAST(CustomerID AS int) AS CustomerID
      , CAST(SalesPersonID AS int) AS SalesPersonID
      , CAST(TerritoryID AS int) AS TerritoryID
      , CAST(BillToAddressID AS int) AS BillToAddressID
      , CAST(ShipToAddressID AS int) AS ShipToAddressID
      , CAST(ShipMethodID AS int) AS ShipMethodID
      , CAST(CreditCardID AS int) AS CreditCardID
      , CAST(CreditCardApprovalCode AS varchar) AS CreditCardApprovalCode
      , CAST(CurrencyRateID AS int) AS CurrencyRateID
      , CAST(SubTotal AS money) AS SubTotal
      , CAST(TaxAmt AS money) AS TaxAmt
      , CAST(Freight AS money) AS Freight
      , CAST(TotalDue AS money) AS TotalDue
      , CAST(Comment AS nvarchar) AS Comment
      , CAST(rowguid AS uniqueidentifier) AS rowguid
      , CAST(ModifiedDate AS datetime) AS ModifiedDate
FROM cte
