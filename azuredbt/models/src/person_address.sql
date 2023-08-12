{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN AddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_AddressID PRIMARY KEY (AddressID)",
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.person_address)
SELECT CAST(AddressID AS int)             AS AddressID
     , CAST(AddressLine1 AS nvarchar(60)) AS AddressLine1
     , CAST(AddressLine2 AS nvarchar(60)) AS AddressLine2
     , CAST(City AS nvarchar(30))         AS City
     , CAST(StateProvinceID AS int)       AS StateProvinceID
     , CAST(PostalCode AS nvarchar(15))   AS PostalCode
     , CAST(SpatialLocation AS nvarchar)  AS SpatialLocation
     , CAST(rowguid AS uniqueidentifier)  AS rowguid
     , CAST(ModifiedDate AS datetime)     AS ModifiedDate
FROM cte





