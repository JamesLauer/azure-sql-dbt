{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN ProductID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_ProductID PRIMARY KEY (ProductID)"
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.production_product)
SELECT CAST(ProductID AS int)              AS ProductID
     , CAST(Name AS nvarchar)              AS Name
     , CAST(ProductNumber AS nvarchar)     AS ProductNumber
     , CAST(MakeFlag AS bit)               AS MakeFlag
     , CAST(FinishedGoodsFlag AS bit)      AS FinishedGoodsFlag
     , CAST(Color AS nvarchar)             AS Color
     , CAST(SafetyStockLevel AS smallint)  AS SafetyStockLevel
     , CAST(ReorderPoint AS smallint)      AS ReorderPoint
     , CAST(StandardCost AS money)         AS StandardCost
     , CAST(ListPrice AS money)            AS ListPrice
     , CAST(Size AS varchar)               AS Size
     , CAST(SizeUnitMeasureCode AS char)   AS SizeUnitMeasureCode
     , CAST(WeightUnitMeasureCode AS char) AS WeightUnitMeasureCode
     , CAST(Weight AS decimal)             AS Weight
     , CAST(DaysToManufacture AS int)      AS DaysToManufacture
     , CAST(ProductLine AS char)           AS ProductLine
     , CAST(Class AS char)                 AS Class
     , CAST(Style AS char)                 AS Style
     , CAST(ProductSubcategoryID AS int)   AS ProductSubcategoryID
     , CAST(ProductModelID AS int)         AS ProductModelID
     , CAST(SellStartDate AS datetime)     AS SellStartDate
     , CAST(SellEndDate AS datetime)       AS SellEndDate
     , CAST(DiscontinuedDate AS datetime)  AS DiscontinuedDate
     , CAST(rowguid AS uniqueidentifier)   AS rowguid
     , CAST(ModifiedDate AS datetime)     AS ModifiedDate
FROM cte
