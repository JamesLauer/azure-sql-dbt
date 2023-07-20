WITH cte AS (
    SELECT * FROM raw_person.countryregion
)
SELECT CAST(CountryRegionCode AS nvarchar) AS CountryRegionCode
      , CAST(Name AS varchar) AS Name
      , CAST(ModifiedDate AS nvarchar) AS ModifiedDate
FROM cte





