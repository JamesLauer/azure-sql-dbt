{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN CountryRegionCode NVARCHAR(2) NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_CountryRegionCode PRIMARY KEY (CountryRegionCode)",
    ]
)}}

WITH cte AS (SELECT *
             FROM raw_person.countryregion)
SELECT CAST(CountryRegionCode AS nvarchar(2)) AS CountryRegionCode
     , CAST(Name AS varchar)               AS Name
     , CONVERT(DATE, ModifiedDate)         AS ModifiedDate
     , CONVERT(TIME, ModifiedDate)         AS ModifiedTime
FROM cte





