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
                              , ProductID
                         FROM dev_src.sales_salesorderdetail),

     src_salesheader AS (SELECT SalesOrderID AS soid
                              , CustomerID
                              , SalesPersonID
                              , TerritoryID
                              , BillToAddressID
                              , ShipToAddressID
                              , ModifiedDate
                         FROM dev_src.sales_salesorderheader),

     dim_customer AS (SELECT DimCustomerID
                         , CustomerID AS cid
                         , PersonID
                         , StoreID
                    FROM dev_dim.dim_customer),

     dim_address AS (SELECT DimAddressID
                          , AddressID
                     FROM dev_dim.dim_address),

     dim_product AS (SELECT DimProductID
                          , ProductID AS pid
                     FROM dev_dim.dim_product),

     dim_salesperson AS (SELECT DimSalespersonID
                              , BusinessEntityID
                         FROM dev_dim.dim_salesperson),

     dim_date AS (SELECT DimDateID
                  FROM dev_dim.dim_date)


SELECT SalesOrderID
     , SalesOrderDetailID
     , DimCustomerID
     , DimAddressID
     , DimProductID
     , DimSalespersonID
     , DimDateID
FROM src_salesdetail
         LEFT JOIN src_salesheader
                   ON src_salesdetail.SalesOrderID = src_salesheader.soid
         LEFT JOIN dim_customer
                   ON src_salesheader.CustomerID = dim_customer.cid
         LEFT JOIN dim_address
                   ON src_salesheader.BillToAddressID = dim_address.AddressID
                       AND src_salesheader.ShipToAddressID = dim_address.AddressID
         LEFT JOIN dim_product
                   ON src_salesdetail.ProductID = dim_product.pid
         LEFT JOIN dim_salesperson
                   ON src_salesheader.SalesPersonID = dim_salesperson.BusinessEntityID
         LEFT JOIN dim_date
                   ON src_salesheader.ModifiedDate = dim_date.DimDateID
