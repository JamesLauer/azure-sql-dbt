{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN ProductSubcategoryID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_ProductSubcategoryID PRIMARY KEY (ProductSubcategoryID)"
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.production_productsubcategory)
SELECT CAST(ProductSubcategoryID AS int) AS ProductSubcategoryID
     , CAST(ProductCategoryID AS int)    AS ProductCategoryID
     , CAST(Name AS nvarchar(50))        AS Name
     , CAST(rowguid AS uniqueidentifier) AS rowguid
     , CAST(ModifiedDate AS datetime)    AS ModifiedDate
FROM cte
