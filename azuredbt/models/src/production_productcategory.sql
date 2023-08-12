{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN ProductCategoryID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_ProductCategoryID PRIMARY KEY (ProductCategoryID)"
    ]
)}}

WITH cte AS (SELECT *
             FROM raw_production.productcategory)
SELECT CAST(ProductCategoryID AS int)    AS ProductCategoryID
     , CAST(Name AS nvarchar(50))        AS Name
     , CAST(rowguid AS uniqueidentifier) AS rowguid
     , CAST(ModifiedDate AS datetime)    AS ModifiedDate
FROM cte
