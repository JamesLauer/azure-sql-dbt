{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_BusinessEntityID PRIMARY KEY (BusinessEntityID)"
    ]
)}}

WITH cte AS (SELECT *
             FROM raw_person.businessentity)
SELECT CAST(BusinessEntityID AS int)     AS BusinessEntityID
     , CAST(rowguid AS uniqueidentifier) AS rowguid
     , CONVERT(DATE, ModifiedDate)       AS ModifiedDate
     , CONVERT(TIME, ModifiedDate)       AS ModifiedTime
FROM cte
