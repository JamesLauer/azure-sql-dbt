{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_salesperson_personbusinessentity FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    ]
)}}

WITH cte AS (SELECT *
             FROM raw_sales.salesperson)
SELECT CAST(BusinessEntityID AS int)     AS BusinessEntityID
     , CAST(TerritoryID AS int)          AS TerritoryID
     , CAST(SalesQuota AS money)         AS SalesQuota
     , CAST(Bonus AS money)              AS Bonus
     , CAST(CommissionPct AS smallmoney) AS CommissionPct
     , CAST(SalesYTD AS money)           AS SalesYTD
     , CAST(SalesLastYear AS money)      AS SalesLastYear
     , CAST(rowguid AS uniqueidentifier) AS rowguid
     , CONVERT(DATE, ModifiedDate)       AS ModifiedDate
     , CONVERT(TIME, ModifiedDate)       AS ModifiedTime
FROM cte
