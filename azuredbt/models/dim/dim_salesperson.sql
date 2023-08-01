{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT business_entity_fk FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    "ALTER TABLE {{ this }} ALTER COLUMN AddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT address_fk FOREIGN KEY (AddressID) REFERENCES dev_src.person_address(AddressID)",
    ]
)}}

WITH src_businessentityaddress AS (SELECT BusinessEntityID
                                   FROM dev_src.sales_salesperson),

     src_address AS (SELECT AddressID
                          , AddressLine1
                          , AddressLine2
                          , City
                          , PostalCode
                          , SpatialLocation
                          , rowguid
                          , ModifiedDate
                     FROM dev_src.person_address)

SELECT BusinessEntityID
     , AddressID
     , AddressLine1
     , AddressLine2
     , City
     , PostalCode
     , SpatialLocation
     , rowguid
     , ModifiedDate
FROM src_businessentityaddress
         LEFT JOIN src_address ON src_businessentityaddress.AddressID = src_address.aid
