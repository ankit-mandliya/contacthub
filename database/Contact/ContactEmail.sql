IF OBJECT_ID(N'dbo.ContactEmail', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ContactEmail
    (
        ContactEmailId INT IDENTITY(1,1) NOT NULL,
        ContactId INT NOT NULL,
        EmailType NVARCHAR(50) NOT NULL,
        EmailAddress NVARCHAR(320) NOT NULL,
        IsPrimary BIT NOT NULL
            CONSTRAINT DF_ContactEmail_IsPrimary DEFAULT (0),
        IsActive BIT NOT NULL
            CONSTRAINT DF_ContactEmail_IsActive DEFAULT (1),
        CreatedBy INT NULL,
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactEmail_CreatedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactEmail_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        CONSTRAINT PK_ContactEmail PRIMARY KEY CLUSTERED (ContactEmailId),
        CONSTRAINT CK_ContactEmail_EmailType_NotBlank
            CHECK (LEN(LTRIM(RTRIM(EmailType))) > 0),
        CONSTRAINT CK_ContactEmail_EmailAddress_NotBlank
            CHECK (LEN(LTRIM(RTRIM(EmailAddress))) > 0),
        CONSTRAINT FK_ContactEmail_Contact
            FOREIGN KEY (ContactId) REFERENCES dbo.Contact (ContactId),
        CONSTRAINT FK_ContactEmail_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ContactEmail_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_ContactEmail_ContactId_EmailAddress'
      AND object_id = OBJECT_ID(N'dbo.ContactEmail')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_ContactEmail_ContactId_EmailAddress
        ON dbo.ContactEmail (ContactId, EmailAddress);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactEmail_ContactId'
      AND object_id = OBJECT_ID(N'dbo.ContactEmail')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactEmail_ContactId
        ON dbo.ContactEmail (ContactId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactEmail_EmailAddress'
      AND object_id = OBJECT_ID(N'dbo.ContactEmail')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactEmail_EmailAddress
        ON dbo.ContactEmail (EmailAddress);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactEmail_IsPrimary'
      AND object_id = OBJECT_ID(N'dbo.ContactEmail')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactEmail_IsPrimary
        ON dbo.ContactEmail (IsPrimary);
END;
GO
