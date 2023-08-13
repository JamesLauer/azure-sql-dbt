{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN TerritoryID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_TerritoryID PRIMARY KEY (TerritoryID)",
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.sales_salesterritory)
SELECT CAST(TerritoryID AS int)           AS TerritoryID
     , CAST(Name AS int)                  AS Name
     , CAST(CountryRegionCode AS int)     AS CountryRegionCode
     , CAST(Group AS int)                 AS TerritoryGroup
     , CAST(SalesLastYear AS varchar(10)) AS SalesLastYear
     , CAST(CostYTD AS int)               AS CostYTD
     , CAST(CostLastYear AS int)          AS CostLastYear
     , CAST(rowguid AS uniqueidentifier)  AS rowguid
     , CAST(ModifiedDate AS datetime)     AS ModifiedDate
FROM cte
