WITH cte AS (
    SELECT * FROM raw_person.businessentityaddress
)
SELECT CAST(BusinessEntityID AS int) AS BusinessEntityID
      , CAST(AddressID AS int) AS AddressID
      , CAST(rowguid AS uniqueidentifier) AS rowguid
      , CAST(ModifiedDate AS datetime) AS ModifiedDate
FROM cte
