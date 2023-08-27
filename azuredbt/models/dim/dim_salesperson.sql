{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ADD DimSalespersonID INT IDENTITY(1,1)",
    "ALTER TABLE {{ this }} ALTER COLUMN DimSalespersonID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_DimSalespersonID PRIMARY KEY (DimSalespersonID)",
    "ALTER TABLE {{ this }} ALTER COLUMN TerritoryID INT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimsalesperson_salessalesterritory FOREIGN KEY (TerritoryID) REFERENCES dev_src.sales_salesterritory(TerritoryID)",
    ]
)}}

WITH src_salesperson AS (SELECT BusinessEntityID
                              , TerritoryID
                              , SalesQuota
                              , Bonus
                              , CommissionPct
                              , SalesYTD
                              , SalesLastYear
                         FROM dev_src.sales_salesperson),

     src_salesterritory AS (SELECT TerritoryID AS tid
                                 , Name
                                 , CountryRegionCode
                                 , TerritoryGroup
                            FROM dev_src.sales_salesterritory),

     src_person AS (SELECT BusinessEntityID AS bid
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
                    FROM dev_src.person_person)

SELECT BusinessEntityID
     , TerritoryID
     , SalesQuota
     , Bonus
     , CommissionPct
     , SalesYTD
     , SalesLastYear
     , Name
     , CountryRegionCode
     , TerritoryGroup
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
FROM src_salesperson
         LEFT JOIN src_salesterritory
                   ON src_salesperson.TerritoryID = src_salesterritory.tid
         LEFT JOIN src_person
                   ON src_salesperson.BusinessEntityID = src_person.bid

