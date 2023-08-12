{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT business_entity_fk FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    "ALTER TABLE {{ this }} ALTER COLUMN AddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT address_fk FOREIGN KEY (AddressID) REFERENCES dev_src.person_address(AddressID)",
    ]
)}}

WITH src_salesperson AS (SELECT BusinessEntityID
                              , TerritoryID
                              , SalesQuota
                              , Bonus
                              , CommissionPct
                              , SalesYTD
                              , SalesLastYear
                         FROM dev_src.sales_salesperson)

SELECT BusinessEntityID
     , AddressID
     , AddressLine1
     , AddressLine2
     , City
     , PostalCode
     , SpatialLocation
FROM src_businessentityaddress
         LEFT JOIN src_address ON src_businessentityaddress.AddressID = src_address.aid
