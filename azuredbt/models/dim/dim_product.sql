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
, Color
, StandardCost
, ListPrice
, Size
, SizeUnitMeasureCode
, WeightUnitMeasureCode
, Weight
, ProductSubcategoryID
, ProductModelID
FROM src_product

