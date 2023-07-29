{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonaddress_personbusinessentity FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    "ALTER TABLE {{ this }} ALTER COLUMN AddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonaddress_personaddress FOREIGN KEY (AddressID) REFERENCES dev_src.person_address(AddressID)",
    ]
)}}

WITH src_businessentityaddress AS (
    SELECT BusinessEntityID
        , AddressID
    FROM dev_src.person_businessentityaddress
),

src_address AS (
    SELECT AddressID AS aid
      , AddressLine1
      , AddressLine2
      , City
      , PostalCode
      , SpatialLocation
      , rowguid
      , ModifiedDate
      , ModifiedTime
    FROM dev_src.person_address
)

SELECT BusinessEntityID
     , AddressID
     , AddressLine1
     , AddressLine2
     , City
     , PostalCode
     , SpatialLocation
     , rowguid
     , ModifiedDate
     , ModifiedTime
FROM src_businessentityaddress
         LEFT JOIN src_address ON src_businessentityaddress.AddressID = src_address.aid
