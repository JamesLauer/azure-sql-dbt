{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN ProductID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT product_fk FOREIGN KEY (ProductID) REFERENCES dev_src.production_product(ProductID)",
    ]
)}}

WITH src_product AS (
    SELECT * FROM dev_src.production_product
)
SELECT ProductID
, Name
, ProductNumber
, MakeFlag
, FinishedGoodsFlag
, Color
, SafetyStockLevel
, ReorderPoint
, StandardCost
, ListPrice
, Size
, SizeUnitMeasureCode
, WeightUnitMeasureCode
, Weight
, DaysToManufacture
, ProductLine
, Class
, Style
, ProductSubcategoryID
, ProductModelID
, SellStartDate
, SellEndDate
, DiscontinuedDate
, rowguid
, ModifiedDate
FROM src_product

