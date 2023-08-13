{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN StateProvinceID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_StateProvinceID PRIMARY KEY (StateProvinceID)"
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.person_stateprovince)
SELECT CAST(StateProvinceID AS int)         AS StateProvinceID
     , CAST(StateProvinceCode AS nchar)     AS StateProvinceCode
     , CAST(CountryRegionCode AS nvarchar)  AS CountryRegionCode
     , CAST(IsOnlyStateProvinceFlag AS bit) AS IsOnlyStateProvinceFlag
     , CAST(Name AS nvarchar)               AS Name
     , CAST(TerritoryID AS int)             AS TerritoryID
     , CAST(rowguid AS uniqueidentifier)    AS rowguid
     , CAST(ModifiedDate AS datetime)       AS ModifiedDate
FROM cte





