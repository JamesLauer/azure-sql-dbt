{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ADD DimPersonID INT IDENTITY(1,1)",
    "ALTER TABLE {{ this }} ALTER COLUMN DimPersonID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_DimPersonID PRIMARY KEY (DimPersonID)",
    "ALTER TABLE {{ this }} ALTER COLUMN CustomerID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonperson_salescustomer FOREIGN KEY (CustomerID) REFERENCES dev_src.sales_customer(CustomerID)",
    "ALTER TABLE {{ this }} ALTER COLUMN PersonID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimpersonperson_personbusinessentity FOREIGN KEY (PersonID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
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
                    FROM dev_src.person_person)

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
     , AdditionalContactInfo
     , Demographics
FROM src_customer
         INNER JOIN src_person
                    ON src_customer.PersonID = src_person.BusinessEntityID