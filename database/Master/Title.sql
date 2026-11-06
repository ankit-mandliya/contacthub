IF OBJECT_ID(N'dbo.Title', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Title
    (
        TitleId INT IDENTITY(1,1) NOT NULL,
        TitleCode NVARCHAR(20) NOT NULL,
        TitleName NVARCHAR(100) NOT NULL,
        DisplayOrder INT NOT NULL
            CONSTRAINT DF_Title_DisplayOrder DEFAULT (0),
        IsActive BIT NOT NULL
            CONSTRAINT DF_Title_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Title_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Title_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_Title PRIMARY KEY CLUSTERED (TitleId),
        CONSTRAINT CK_Title_TitleCode_NotBlank
            CHECK (LEN(LTRIM(RTRIM(TitleCode))) > 0),
        CONSTRAINT CK_Title_TitleName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(TitleName))) > 0),
        CONSTRAINT CK_Title_DisplayOrder_NonNegative
            CHECK (DisplayOrder >= 0),
        CONSTRAINT FK_Title_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_Title_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Title_TitleCode'
      AND object_id = OBJECT_ID(N'dbo.Title')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Title_TitleCode
        ON dbo.Title (TitleCode);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Title_TitleName'
      AND object_id = OBJECT_ID(N'dbo.Title')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Title_TitleName
        ON dbo.Title (TitleName);
END;
GO
