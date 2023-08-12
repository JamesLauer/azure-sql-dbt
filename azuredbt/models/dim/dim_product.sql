{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ADD DimProductID INT IDENTITY(1,1)",
    "ALTER TABLE {{ this }} ALTER COLUMN DimProductID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_DimProductID PRIMARY KEY (DimProductID)",
    "ALTER TABLE {{ this }} ALTER COLUMN ProductID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimproduct_productionproduct FOREIGN KEY (ProductID) REFERENCES dev_src.production_product(ProductID)",
    "ALTER TABLE {{ this }} ALTER COLUMN ProductCategoryID INT",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimproduct_productionproductcategory FOREIGN KEY (ProductCategoryID) REFERENCES dev_src.production_productcategory(ProductCategoryID)",
    "ALTER TABLE {{ this }} ALTER COLUMN ProductSubcategoryID INT",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimproduct_productionproductsubcategory FOREIGN KEY (ProductSubcategoryID) REFERENCES dev_src.production_productsubcategory(ProductSubcategoryID)",
    ]
)}}

WITH src_product AS (SELECT ProductID
                          , Name
                          , ProductNumber
                          , Color
                          , ReorderPoint
                          , StandardCost
                          , ListPrice
                          , Size
                          , Weight
                          , ProductSubcategoryID
                     FROM dev_src.production_product),

     src_productcategory AS (SELECT ProductCategoryID
                                  , Name AS ProductCategory
                             FROM dev_src.production_productcategory),

     src_productsubcategory AS (SELECT ProductSubcategoryID AS psid
                                     , ProductCategoryID    AS pcid
                                     , Name                 AS ProductSubcategory
                                FROM dev_src.production_productsubcategory)


SELECT ProductID
     , Name
     , ProductNumber
     , Color
     , StandardCost
     , ListPrice
     , Size
     , Weight
     , ProductSubcategory
     , ProductSubcategoryID
     , ProductCategory
     , pcid AS ProductCategoryID
FROM src_product
         LEFT JOIN src_productsubcategory
                   ON src_product.ProductSubcategoryID = src_productsubcategory.pcid
         LEFT JOIN src_productcategory
                   ON src_productsubcategory.pcid = src_productcategory.ProductCategoryID
