WITH cte AS (SELECT *
             FROM dev_raw.sales_salesperson)
SELECT CAST(BusinessEntityID AS int)     AS BusinessEntityID
     , CAST(TerritoryID AS int)          AS TerritoryID
     , CAST(SalesQuota AS money)         AS SalesQuota
     , CAST(Bonus AS money)              AS Bonus
     , CAST(CommissionPct AS smallmoney) AS CommissionPct
     , CAST(SalesYTD AS money)           AS SalesYTD
     , CAST(SalesLastYear AS money)      AS SalesLastYear
     , CAST(rowguid AS uniqueidentifier) AS rowguid
     , CAST(ModifiedDate AS datetime)    AS ModifiedDate
FROM cte
