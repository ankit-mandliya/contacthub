IF OBJECT_ID(N'dbo.Country', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Country
    (
        CountryId INT IDENTITY(1,1) NOT NULL,
        CountryCode NVARCHAR(20) NOT NULL,
        CountryName NVARCHAR(150) NOT NULL,
        ISO2Code CHAR(2) NOT NULL,
        ISO3Code CHAR(3) NOT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_Country_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Country_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Country_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_Country PRIMARY KEY CLUSTERED (CountryId),
        CONSTRAINT CK_Country_CountryCode_NotBlank
            CHECK (LEN(LTRIM(RTRIM(CountryCode))) > 0),
        CONSTRAINT CK_Country_CountryName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(CountryName))) > 0),
        CONSTRAINT CK_Country_ISO2Code_Valid
            CHECK
            (
                LEN(LTRIM(RTRIM(ISO2Code))) = 2
                AND ISO2Code COLLATE Latin1_General_100_BIN2 = UPPER(ISO2Code)
                AND ISO2Code COLLATE Latin1_General_100_BIN2 NOT LIKE '%[^A-Z]%'
            ),
        CONSTRAINT CK_Country_ISO3Code_Valid
            CHECK
            (
                LEN(LTRIM(RTRIM(ISO3Code))) = 3
                AND ISO3Code COLLATE Latin1_General_100_BIN2 = UPPER(ISO3Code)
                AND ISO3Code COLLATE Latin1_General_100_BIN2 NOT LIKE '%[^A-Z]%'
            ),
        CONSTRAINT FK_Country_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_Country_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Country_CountryCode'
      AND object_id = OBJECT_ID(N'dbo.Country')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Country_CountryCode
        ON dbo.Country (CountryCode);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Country_CountryName'
      AND object_id = OBJECT_ID(N'dbo.Country')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Country_CountryName
        ON dbo.Country (CountryName);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Country_ISO2Code'
      AND object_id = OBJECT_ID(N'dbo.Country')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Country_ISO2Code
        ON dbo.Country (ISO2Code);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Country_ISO3Code'
      AND object_id = OBJECT_ID(N'dbo.Country')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Country_ISO3Code
        ON dbo.Country (ISO3Code);
END;
GO
