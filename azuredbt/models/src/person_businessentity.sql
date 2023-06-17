{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT business_entity_pk PRIMARY KEY (BusinessEntityID)"
    ]
)}}

WITH cte AS (
    SELECT * FROM raw_person.businessentity
)
SELECT CAST(BusinessEntityID AS int) AS BusinessEntityID
      , CAST(rowguid AS uniqueidentifier) AS rowguid
      , CAST(ModifiedDate AS datetime) AS ModifiedDate
FROM cte
