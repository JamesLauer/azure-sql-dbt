{{ config(
    post_hook=[
    "ALTER TABLE {{ this }} ALTER COLUMN DimDateID datetime NOT NULL",
    "ALTER TABLE {{ this }} ADD CONSTRAINT PK_DimDateID PRIMARY KEY (DimDateID)",
    ]
)}}

WITH cte AS (SELECT *
             FROM dev_raw.dates)
SELECT CAST(TheDate AS datetime)         AS DimDateID
     , CAST(TheDay AS tinyint)           AS TheDay
     , CAST(TheDayName AS varchar(9))    AS TheDayName
     , CAST(TheWeek AS tinyint)          AS TheWeek
     , CAST(TheISOWeek AS tinyint)       AS TheISOWeek
     , CAST(TheMonth AS tinyint)         AS TheMonth
     , CAST(TheMonthName AS varchar(9))  AS TheMonthName
     , CAST(TheQuarter AS tinyint)       AS TheQuarter
     , CAST(TheYear AS int)              AS TheYear
     , CAST(TheFirstOfMonth AS datetime) AS TheFirstOfMonth
     , CAST(TheLastOfYear AS datetime)   AS TheLastOfYear
     , CAST(TheDayOfYear AS int)         AS TheDayOfYear
FROM cte





