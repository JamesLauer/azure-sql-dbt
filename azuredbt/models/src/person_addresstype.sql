{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN AddressTypeID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_AddressTypeID PRIMARY KEY (AddressTypeID)",
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.person_addresstype)
SELECT CAST(AddressTypeID AS int)        AS AddressTypeID
     , CAST(Name AS varchar)             AS AddressType
     , CAST(rowguid AS uniqueidentifier) AS rowguid
     , CAST(ModifiedDate AS datetime)     AS ModifiedDate
FROM cte





