IF OBJECT_ID(N'dbo.ContactPhone', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ContactPhone
    (
        ContactPhoneId INT IDENTITY(1,1) NOT NULL,
        ContactId INT NOT NULL,
        PhoneType NVARCHAR(50) NOT NULL,
        CountryCode NVARCHAR(10) NULL,
        PhoneNumber NVARCHAR(50) NOT NULL,
        Extension NVARCHAR(20) NULL,
        IsPrimary BIT NOT NULL
            CONSTRAINT DF_ContactPhone_IsPrimary DEFAULT (0),
        IsActive BIT NOT NULL
            CONSTRAINT DF_ContactPhone_IsActive DEFAULT (1),
        CreatedBy INT NULL,
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactPhone_CreatedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactPhone_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        CONSTRAINT PK_ContactPhone PRIMARY KEY CLUSTERED (ContactPhoneId),
        CONSTRAINT CK_ContactPhone_PhoneType_NotBlank
            CHECK (LEN(LTRIM(RTRIM(PhoneType))) > 0),
        CONSTRAINT CK_ContactPhone_PhoneNumber_NotBlank
            CHECK (LEN(LTRIM(RTRIM(PhoneNumber))) > 0),
        CONSTRAINT FK_ContactPhone_Contact
            FOREIGN KEY (ContactId) REFERENCES dbo.Contact (ContactId),
        CONSTRAINT FK_ContactPhone_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ContactPhone_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactPhone_ContactId'
      AND object_id = OBJECT_ID(N'dbo.ContactPhone')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactPhone_ContactId
        ON dbo.ContactPhone (ContactId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactPhone_PhoneNumber'
      AND object_id = OBJECT_ID(N'dbo.ContactPhone')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactPhone_PhoneNumber
        ON dbo.ContactPhone (PhoneNumber);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactPhone_IsPrimary'
      AND object_id = OBJECT_ID(N'dbo.ContactPhone')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactPhone_IsPrimary
        ON dbo.ContactPhone (IsPrimary);
END;
GO
