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
                          , ModifiedDate
                     FROM dev_src.person_address
                     WHERE ModifiedDate = (SELECT MAX(ModifiedDate)
                                           FROM dev_src.person_address)),

     src_stateprovince AS (SELECT StateProvinceID   AS spid
                                , CountryRegionCode AS sprc
                                , Name              AS State
                           FROM dev_src.person_stateprovince),

     src_countryregion AS (SELECT CountryRegionCode
                                , Name AS Country
                           FROM dev_src.person_countryregion)

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
--      , AddressLine1
--      , AddressLine2
--      , City
--      , State
--      , Country
--      , PostalCode
--      , SpatialLocation
     , AdditionalContactInfo
     , Demographics
     , ModifiedDate
FROM src_customer
         INNER JOIN src_person
                   ON src_customer.PersonID = src_person.BusinessEntityID
         INNER JOIN src_businessentityaddress
                   ON src_person.BusinessEntityID = src_businessentityaddress.bid
--          LEFT JOIN src_address
--                    ON src_businessentityaddress.AddressID = src_address.aid
--          LEFT JOIN src_stateprovince
--                    ON src_address.StateProvinceID = src_stateprovince.spid
--          LEFT JOIN src_countryregion
--                    ON src_stateprovince.sprc = src_countryregion.CountryRegionCode

