{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN BusinessEntityID INT NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT FK_personperson_personbusinessentity FOREIGN KEY (BusinessEntityID) REFERENCES dev_src.person_businessentity(BusinessEntityID)",
    ]
)}}

WITH cte AS (SELECT *
             FROM raw_person.person)
SELECT CAST(BusinessEntityID AS int)      AS BusinessEntityID
     , CAST(PersonType AS nchar(2))       AS PersonType
     , CAST(NameStyle AS bit)             AS NameStyle
     , CAST(Title AS nvarchar(8))         AS Title
     , CAST(FirstName AS nvarchar(50))    AS FirstName
     , CAST(MiddleName AS nvarchar(50))   AS MiddleName
     , CAST(LastName AS nvarchar(50))     AS LastName
     , CAST(Suffix AS nvarchar(50))       AS Suffix
     , CAST(EmailPromotion AS int)        AS EmailPromotion
     , CAST(AdditionalContactInfo AS xml) AS AdditionalContactInfo
     , CAST(Demographics AS xml)          AS Demographics
     , CAST(rowguid AS uniqueidentifier)  AS rowguid
     , CAST(ModifiedDate AS datetime)     AS ModifiedDate
FROM cte
