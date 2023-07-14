{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT business_entity_person_fk FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    ]
)}}

WITH cte AS (
    SELECT * FROM raw_person.person
)
SELECT CAST(BusinessEntityID AS int) AS BusinessEntityID
      , CAST(PersonType AS nchar) AS PersonType
      , CAST(NameStyle AS varchar) AS NameStyle
      , CAST(Title AS varchar) AS Title
      , CAST(FirstName AS nvarchar) AS FirstName
      , CAST(MiddleName AS nvarchar) AS MiddleName
      , CAST(LastName AS nvarchar) AS LastName
      , CAST(Suffix AS nvarchar) AS Suffix
      , CAST(EmailPromotion AS int) AS EmailPromotion
      , CAST(AdditionalContactInfo AS xml) AS AdditionalContactInfo
      , CAST(Demographics AS xml) AS Demographics
      , CAST(rowguid AS uniqueidentifier) AS rowguid
      , CAST(ModifiedDate AS datetime) AS ModifiedDate
FROM cte
