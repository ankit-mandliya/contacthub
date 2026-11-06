IF OBJECT_ID(N'dbo.ContactRelationship', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ContactRelationship
    (
        ContactRelationshipId INT IDENTITY(1,1) NOT NULL,
        ContactId INT NOT NULL,
        RelationshipType NVARCHAR(50) NOT NULL,
        FirstName NVARCHAR(100) NOT NULL,
        LastName NVARCHAR(100) NULL,
        PhoneType NVARCHAR(50) NULL,
        PhoneNumber NVARCHAR(50) NULL,
        EmailType NVARCHAR(50) NULL,
        EmailAddress NVARCHAR(320) NULL,
        Notes NVARCHAR(1000) NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_ContactRelationship_IsActive DEFAULT (1),
        CreatedBy INT NULL,
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactRelationship_CreatedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactRelationship_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        CONSTRAINT PK_ContactRelationship PRIMARY KEY CLUSTERED (ContactRelationshipId),
        CONSTRAINT CK_ContactRelationship_RelationshipType_NotBlank
            CHECK (LEN(LTRIM(RTRIM(RelationshipType))) > 0),
        CONSTRAINT CK_ContactRelationship_FirstName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(FirstName))) > 0),
        CONSTRAINT FK_ContactRelationship_Contact
            FOREIGN KEY (ContactId) REFERENCES dbo.Contact (ContactId),
        CONSTRAINT FK_ContactRelationship_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ContactRelationship_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactRelationship_ContactId'
      AND object_id = OBJECT_ID(N'dbo.ContactRelationship')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactRelationship_ContactId
        ON dbo.ContactRelationship (ContactId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactRelationship_RelationshipType'
      AND object_id = OBJECT_ID(N'dbo.ContactRelationship')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactRelationship_RelationshipType
        ON dbo.ContactRelationship (RelationshipType);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactRelationship_LastName'
      AND object_id = OBJECT_ID(N'dbo.ContactRelationship')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactRelationship_LastName
        ON dbo.ContactRelationship (LastName);
END;
GO
