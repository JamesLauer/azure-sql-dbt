{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN CountryRegionCode NVARCHAR(2) NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_CountryRegionCode PRIMARY KEY (CountryRegionCode)",
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.person_countryregion)
SELECT CAST(CountryRegionCode AS nvarchar(2)) AS CountryRegionCode
     , CAST(Name AS varchar)               AS Name
     , CAST(ModifiedDate AS datetime)     AS ModifiedDate
FROM cte





