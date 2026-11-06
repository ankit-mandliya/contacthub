IF OBJECT_ID(N'dbo.ContactSource', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ContactSource
    (
        ContactSourceId INT IDENTITY(1,1) NOT NULL,
        ContactSourceName NVARCHAR(100) NOT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_ContactSource_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactSource_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactSource_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_ContactSource
            PRIMARY KEY CLUSTERED (ContactSourceId),
        CONSTRAINT CK_ContactSource_Name_NotBlank
            CHECK (LEN(LTRIM(RTRIM(ContactSourceName))) > 0),
        CONSTRAINT FK_ContactSource_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ContactSource_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_ContactSource_Name'
      AND object_id = OBJECT_ID(N'dbo.ContactSource')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_ContactSource_Name
        ON dbo.ContactSource (ContactSourceName);
END;
GO
