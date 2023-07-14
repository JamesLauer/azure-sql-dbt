{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT business_entity_person_fk_person_person FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    ]
)}}

WITH src_person AS (
    SELECT * FROM dev_src.person_person
)
SELECT BusinessEntityID
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
FROM src_person

