WITH src_customer AS (SELECT CustomerID
                           , PersonID
                           , AccountNumber
                           , ModifiedDate AS ModifiedDateCustomer
                           , ModifiedTime AS ModifiedTimeCustomer
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
                         , ModifiedDate AS ModifiedDatePerson
                         , ModifiedTime AS ModifiedTimePerson
                    FROM dev_src.person_person),

     src_businessentityaddress AS (SELECT BusinessEntityID AS bid
                                        , AddressID
                                        , ModifiedDate     AS ModifiedDateBEAddress
                                        , ModifiedTime     AS ModifiedTimeBEAddress
                                   FROM dev_src.person_businessentityaddress),

     src_address AS (SELECT AddressID    AS aid
                          , AddressLine1
                          , AddressLine2
                          , City
                          , StateProvinceID
                          , PostalCode
                          , SpatialLocation
                          , ModifiedDate AS ModifiedDateAddress
                          , ModifiedTime AS ModifiedTimeAddress
                     FROM dev_src.person_address),
--                      WHERE ModifiedDate = (SELECT MAX(ModifiedDate)
--                                            FROM dev_src.person_address
--                                            WHERE ModifiedDate IS NOT NULL)),

     src_stateprovince AS (SELECT StateProvinceID   AS spid
                                , CountryRegionCode AS sprc
                                , Name              AS State
                           FROM dev_src.person_stateprovince),

     src_countryregion AS (SELECT CountryRegionCode
                                , Name AS Country
                           FROM dev_src.person_countryregion)

SELECT CustomerID
     , PersonID AS BusinessEntityID
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
     , State
     , Country
     , PostalCode
     , SpatialLocation
     , AdditionalContactInfo
     , Demographics
     , ModifiedDateCustomer
     , ModifiedTimeCustomer
     , ModifiedDatePerson
     , ModifiedTimePerson
     , ModifiedDateBEAddress
     , ModifiedTimeBEAddress
     , ModifiedDateAddress
     , ModifiedTimeAddress
FROM src_customer
         -- Note that PersonID is same as BusinessEntityID
         -- By performing an INNER JOIN, only customers with a BusinessEntityID and PersonID are joined, therefore this excludes
         INNER JOIN src_person
                    ON src_customer.PersonID = src_person.BusinessEntityID
         LEFT JOIN src_businessentityaddress
                   ON src_person.BusinessEntityID = src_businessentityaddress.bid
         LEFT JOIN src_address
                   ON src_businessentityaddress.AddressID = src_address.aid
         LEFT JOIN src_stateprovince
                   ON src_address.StateProvinceID = src_stateprovince.spid
         LEFT JOIN src_countryregion
                   ON src_stateprovince.sprc = src_countryregion.CountryRegionCode

