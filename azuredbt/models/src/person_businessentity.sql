{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_BusinessEntityID PRIMARY KEY (BusinessEntityID)"
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.person_businessentity)
SELECT CAST(BusinessEntityID AS int)     AS BusinessEntityID
     , CAST(rowguid AS uniqueidentifier) AS rowguid
     , CAST(ModifiedDate AS datetime)     AS ModifiedDate
FROM cte
