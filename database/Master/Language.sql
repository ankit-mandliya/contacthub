IF OBJECT_ID(N'dbo.[Language]', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.[Language]
    (
        LanguageId INT IDENTITY(1,1) NOT NULL,
        LanguageCode NVARCHAR(35) NOT NULL,
        LanguageName NVARCHAR(100) NOT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_Language_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Language_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Language_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_Language PRIMARY KEY CLUSTERED (LanguageId),
        CONSTRAINT CK_Language_LanguageCode_NotBlank
            CHECK (LEN(LTRIM(RTRIM(LanguageCode))) > 0),
        CONSTRAINT CK_Language_LanguageName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(LanguageName))) > 0),
        CONSTRAINT FK_Language_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_Language_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Language_LanguageCode'
      AND object_id = OBJECT_ID(N'dbo.[Language]')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Language_LanguageCode
        ON dbo.[Language] (LanguageCode);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Language_LanguageName'
      AND object_id = OBJECT_ID(N'dbo.[Language]')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Language_LanguageName
        ON dbo.[Language] (LanguageName);
END;
GO
