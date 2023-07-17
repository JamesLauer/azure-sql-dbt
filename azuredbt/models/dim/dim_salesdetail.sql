{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN SalesOrderID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT sales_order_fk_sales_detail FOREIGN KEY (SalesOrderID) REFERENCES dev_src.sales_salesorderheader(SalesOrderID)",
    "ALTER TABLE {{ this }} ALTER COLUMN SalesOrderDetailID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT sales_order_detail_fk_sales_detail FOREIGN KEY (SalesOrderDetailID) REFERENCES dev_src.sales_salesorderdetail(SalesOrderDetailID)",
    "ALTER TABLE {{ this }} ALTER COLUMN ProductID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT product_order_detail_fk_sales_detail FOREIGN KEY (ProductID) REFERENCES dev_src.production_product(ProductID)",
    "ALTER TABLE {{ this }} ALTER COLUMN CustomerID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT customer_fk_sales_detail FOREIGN KEY (CustomerID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
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


