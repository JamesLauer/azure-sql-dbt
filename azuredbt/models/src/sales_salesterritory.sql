{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN TerritoryID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_TerritoryID PRIMARY KEY (TerritoryID)",
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.sales_territory)
SELECT CAST(TerritoryID AS int)               AS TerritoryID
     , CAST(Name AS nvarchar(50))             AS Name
     , CAST(CountryRegionCode AS nvarchar(3)) AS CountryRegionCode
     , CAST(TerritoryGroup AS nvarchar(50))   AS TerritoryGroup
     , CAST(SalesLastYear AS money)           AS SalesLastYear
     , CAST(CostYTD AS money)                 AS CostYTD
     , CAST(CostLastYear AS money)            AS CostLastYear
     , CAST(rowguid AS uniqueidentifier)      AS rowguid
     , CAST(ModifiedDate AS datetime)         AS ModifiedDate
FROM cte
