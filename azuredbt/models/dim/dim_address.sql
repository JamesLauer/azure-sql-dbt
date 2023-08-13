{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ADD DimAddressID INT IDENTITY(1,1)",
    "ALTER TABLE {{ this }} ALTER COLUMN DimAddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_DimAddressID PRIMARY KEY (DimAddressID)",
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonaddress_personbusinessentity FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    "ALTER TABLE {{ this }} ALTER COLUMN AddressID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonaddress_personaddress FOREIGN KEY (AddressID) REFERENCES dev_src.person_address(AddressID)",
    "ALTER TABLE {{ this }} ALTER COLUMN AddressTypeID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonaddress_personaddresstype FOREIGN KEY (AddressTypeID) REFERENCES dev_src.person_addresstype(AddressTypeID)",
    "ALTER TABLE {{ this }} ALTER COLUMN StateProvinceID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonaddress_personstateprovince FOREIGN KEY (StateProvinceID) REFERENCES dev_src.person_stateprovinces(StateProvinceID)",
    "ALTER TABLE {{ this }} ALTER COLUMN CountryRegionCode NVARCHAR(2) NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonaddress_personcountryregion FOREIGN KEY (CountryRegionCode) REFERENCES dev_src.person_countryregion(CountryRegionCode)",
    ]
)}}

WITH src_businessentityaddress AS (SELECT BusinessEntityID
                                        , AddressID
                                        , AddressTypeID AS atid
                                   FROM dev_src.person_businessentityaddress),

     src_address AS (SELECT AddressID AS aid
                          , AddressLine1
                          , AddressLine2
                          , City
                          , StateProvinceID
                          , PostalCode
                          , SpatialLocation
                     FROM dev_src.person_address),

     src_addresstype AS (SELECT AddressTypeID
                              , AddressType
                         FROM dev_src.person_addresstype),

     src_stateprovince AS (SELECT StateProvinceID   AS spid
                                , CountryRegionCode AS sprc
                                , Name              AS State
                           FROM dev_src.person_stateprovinces),

     src_countryregion AS (SELECT CountryRegionCode
                                , Name AS Country
                           FROM dev_src.person_countryregion)

SELECT BusinessEntityID
     , AddressID
     , AddressTypeID
     , StateProvinceID
     , CountryRegionCode
     , AddressLine1
     , AddressLine2
     , City
     , State
     , Country
     , PostalCode
     , SpatialLocation
     , AddressType
FROM src_businessentityaddress
         LEFT JOIN src_address
                   ON src_businessentityaddress.AddressID = src_address.aid
         LEFT JOIN src_addresstype
                   ON src_businessentityaddress.atid = src_addresstype.AddressTypeID
         LEFT JOIN src_stateprovince
                   ON src_address.StateProvinceID = src_stateprovince.spid
         LEFT JOIN src_countryregion
                   ON src_stateprovince.sprc = src_countryregion.CountryRegionCode
