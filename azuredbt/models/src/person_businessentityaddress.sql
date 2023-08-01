{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN AddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_personbusinessentityaddress_personaddress FOREIGN KEY (AddressID) REFERENCES dev_src.person_address(AddressID)",
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_personbusinessentityaddress_personbusinessentity FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    "ALTER TABLE {{ this }} ALTER COLUMN AddressTypeID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_personbusinessentityaddress_personaddresstype FOREIGN KEY (AddressTypeID) REFERENCES dev_src.person_addresstype(AddressTypeID)",]
)}}

WITH cte AS (SELECT *
             FROM raw_person.businessentityaddress)
SELECT CAST(BusinessEntityID AS int)     AS BusinessEntityID
     , CAST(AddressID AS int)            AS AddressID
     , CAST(AddressTypeID AS int)        AS AddressTypeID
     , CAST(rowguid AS uniqueidentifier) AS rowguid
     , CONVERT(DATE, ModifiedDate)       AS ModifiedDate
     , CONVERT(TIME, ModifiedDate)       AS ModifiedTime
FROM cte
