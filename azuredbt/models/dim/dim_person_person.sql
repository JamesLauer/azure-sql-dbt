{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN CustomerID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT customerid_fk_person_person FOREIGN KEY (CustomerID) REFERENCES dev_src.sales_customer(CustomerID)",
    ]
)}}

WITH src_customer AS (SELECT CustomerID
                           , PersonID
                           , AccountNumber
                      FROM dev_src.sales_customer),

     src_person AS (SELECT BusinessEntityID
                         , PersonType
                         , NameStyle
                         , Title
                         , FirstName
                         , MiddleName
                         , LastName
                         , Suffix
                         , EmailPromotion
                         , AdditionalContactInfo
                         , Demographics
                    FROM dev_src.person_person),

     src_businessentityaddress AS (SELECT BusinessEntityID AS bid
                                        , AddressID
                                   FROM dev_src.person_businessentityaddress),

     src_address AS (SELECT AddressID AS aid
                          , AddressLine1
                          , AddressLine2
                          , City
                          , StateProvinceID
                          , PostalCode
                          , SpatialLocation
                     FROM dev_src.person_address),

     src_stateprovince AS (SELECT StateProvinceID AS spid
                      , Name
                    FROM dev_src.person_stateprovince)

SELECT CustomerID
     , PersonID
     , AccountNumber
     , PersonType
     , NameStyle
     , Title
     , FirstName
     , MiddleName
     , LastName
     , Suffix
     , AddressLine1
     , AddressLine2
     , City
     , PostalCode
     , SpatialLocation
     , AdditionalContactInfo
     , Demographics
FROM src_customer
         LEFT JOIN src_person
                   ON src_customer.PersonID = src_person.BusinessEntityID
         LEFT JOIN src_businessentityaddress
                   ON src_person.BusinessEntityID = src_businessentityaddress.bid
         LEFT JOIN src_address
                   ON src_businessentityaddress.AddressID = src_address.aid
         LEFT JOIN src_stateprovince
                   ON src_address.StateProvinceID = src_stateprovince.spid

