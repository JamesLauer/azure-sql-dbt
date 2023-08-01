{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ADD DimSalesDetailID INT IDENTITY(1,1)",
    "ALTER TABLE {{ this }} ALTER COLUMN DimSalesDetailID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_DimSalesDetailID PRIMARY KEY (DimSalesDetailID)",
    "ALTER TABLE {{ this }} ALTER COLUMN SalesOrderID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimsalesdetail_salesorderheader FOREIGN KEY (SalesOrderID) REFERENCES dev_src.sales_salesorderheader(SalesOrderID)",
    "ALTER TABLE {{ this }} ALTER COLUMN SalesOrderDetailID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimsalesdetail_salessalesorderdetail FOREIGN KEY (SalesOrderDetailID) REFERENCES dev_src.sales_salesorderdetail(SalesOrderDetailID)",
    "ALTER TABLE {{ this }} ALTER COLUMN ProductID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimsalesdetail_productionproduct FOREIGN KEY (ProductID) REFERENCES dev_src.production_product(ProductID)",
    "ALTER TABLE {{ this }} ALTER COLUMN CustomerID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimsalesdetail_salescustomer FOREIGN KEY (CustomerID) REFERENCES dev_src.sales_customer(CustomerID)",
    ]
)}}

WITH src_salesdetail AS (SELECT SalesOrderID
                              , SalesOrderDetailID
                              , CarrierTrackingNumber
                              , OrderQty
                              , ProductID
                              , UnitPrice
                              , UnitPriceDiscount
                              , LineTotal
                         FROM dev_src.sales_salesorderdetail),

     src_salesheader AS (SELECT SalesOrderID AS soid
                              , RevisionNumber
                              , OrderDate
                              , DueDate
                              , ShipDate
                              , Status
                              , OnlineOrderFlag
                              , SalesOrderNumber
                              , PurchaseOrderNumber
                              , AccountNumber
                              , CustomerID
                              , SalesPersonID
                              , TerritoryID
                              , BillToAddressID
                              , ShipToAddressID
                              , ShipMethodID
                              , CreditCardID
                              , CreditCardApprovalCode
                              , CurrencyRateID
                              , SubTotal
                              , TaxAmt
                              , Freight
                              , TotalDue
                              , Comment
                         FROM dev_src.sales_salesorderheader)

SELECT SalesOrderID
     , SalesOrderDetailID
     , CarrierTrackingNumber
     , OrderQty
     , ProductID
     , UnitPrice
     , UnitPriceDiscount
     , LineTotal
     , RevisionNumber
     , OrderDate
     , DueDate
     , ShipDate
     , Status
     , OnlineOrderFlag
     , SalesOrderNumber
     , PurchaseOrderNumber
     , AccountNumber
     , CustomerID
     , SalesPersonID
     , TerritoryID
     , BillToAddressID
     , ShipToAddressID
     , ShipMethodID
     , CreditCardID
     , CreditCardApprovalCode
     , CurrencyRateID
     , SubTotal AS SubTotalPerOrder
     , TaxAmt   AS TaXAmtPerOrder
     , Freight  AS FreightPerOrder
     , TotalDue AS TotalDuePerOrder
     , Comment
FROM src_salesdetail
         LEFT JOIN src_salesheader ON src_salesdetail.SalesOrderID = src_salesheader.soid


