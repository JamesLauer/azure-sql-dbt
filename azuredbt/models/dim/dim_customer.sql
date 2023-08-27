{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN CustomerKey varchar(50) NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_CustomerKey PRIMARY KEY (CustomerKey)",
    "DROP INDEX PK_CustomerKey ON dev_dim.dev_customer"
    "ALTER TABLE {{ this }} ALTER COLUMN CustomerID int NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_dimcustomer_salescustomer FOREIGN KEY (CustomerID) REFERENCES dev_src.sales_customer(CustomerID)",
    ]
)}}


WITH src_customer AS (SELECT CustomerID
                           , PersonID
                           , StoreID
                           , AccountNumber
                           , rowguid
                           , ModifiedDate
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
                         , rowguid
                         , ModifiedDate
                    FROM dev_src.person_person)

SELECT {{ dbt_utils.generate_surrogate_key(['CustomerID', 'PersonID']) }} AS CustomerKey
     , CustomerID
     , PersonID
     , StoreID
     , AccountNumber
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
FROM src_customer
         INNER JOIN src_person
                    ON src_customer.PersonID = src_person.BusinessEntityID