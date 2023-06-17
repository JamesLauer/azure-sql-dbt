{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN AddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT person_address_pk PRIMARY KEY (AddressID)"
    ]
)}}

WITH cte AS (
    SELECT * FROM raw_person.address
)
SELECT CAST(AddressID AS int) AS AddressID
      , CAST(AddressLine1 AS varchar) AS AddressLine1
      , CAST(AddressLine2 AS varchar) AS AddressLine2
      , CAST(City AS varchar) AS City
      , CAST(StateProvinceID AS int) AS StateProvinceID
      , CAST(PostalCode AS nvarchar) AS PostalCode
      , CAST(SpatialLocation AS nvarchar) AS SpatialLocation
      , CAST(rowguid AS uniqueidentifier) AS rowguid
      , CAST(ModifiedDate AS datetime) AS ModifiedDate
FROM cte





