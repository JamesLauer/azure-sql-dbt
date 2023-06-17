{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT business_entity_fk FOREIGN KEY (BusinessEntityID) REFERENCES src.person_businessentity(BusinessEntityID)",
    "ALTER TABLE {{ this }} ALTER COLUMN AddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT address_fk FOREIGN KEY (AddressID) REFERENCES src.person_address(AddressID)"
    "ALTER TABLE {{ this }} ALTER COLUMN AddressTypeID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT address_type_businessentityaddress_fk FOREIGN KEY (AddressTypeID) REFERENCES src.person_address(AddressID)",
    ]
)}}

WITH cte AS (
    SELECT * FROM raw_person.businessentityaddress
)
SELECT CAST(BusinessEntityID AS int) AS BusinessEntityID
      , CAST(AddressID AS int) AS AddressID
      , CAST(AddressTypeID AS int) AS AddressTypeID
      , CAST(rowguid AS uniqueidentifier) AS rowguid
      , CAST(ModifiedDate AS datetime) AS ModifiedDate
FROM cte
