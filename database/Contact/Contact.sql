IF OBJECT_ID(N'dbo.Contact', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Contact
    (
        ContactId INT IDENTITY(1,1) NOT NULL,
        TitleId INT NULL,
        FirstName NVARCHAR(100) NOT NULL,
        LastName NVARCHAR(100) NOT NULL,
        PreferredName NVARCHAR(100) NULL,
        Gender NVARCHAR(20) NULL,
        PreferredLanguageId INT NULL,
        CountryId INT NULL,
        Address NVARCHAR(500) NULL,
        PostalCode NVARCHAR(20) NULL,
        CompanyName NVARCHAR(200) NULL,
        JobTitle NVARCHAR(150) NULL,
        DesignationId INT NULL,
        DepartmentId INT NULL,
        ClassificationTypeId INT NULL,
        ClassificationSegmentId INT NULL,
        ConfidentialityLevelId INT NULL,
        ValidationStatusId INT NULL,
        AccessIndividual BIT NOT NULL
            CONSTRAINT DF_Contact_AccessIndividual DEFAULT (0),
        AccessGroup BIT NOT NULL
            CONSTRAINT DF_Contact_AccessGroup DEFAULT (0),
        ContactOwnerUserId INT NULL,
        Status NVARCHAR(50) NULL,
        Tags NVARCHAR(500) NULL,
        Notes NVARCHAR(1000) NULL,
        LinkedInId NVARCHAR(255) NULL,
        BelongsToGroup BIT NOT NULL
            CONSTRAINT DF_Contact_BelongsToGroup DEFAULT (0),
        IsActive BIT NOT NULL
            CONSTRAINT DF_Contact_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Contact_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Contact_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_Contact PRIMARY KEY CLUSTERED (ContactId),
        CONSTRAINT CK_Contact_FirstName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(FirstName))) > 0),
        CONSTRAINT CK_Contact_LastName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(LastName))) > 0),
        CONSTRAINT FK_Contact_Title
            FOREIGN KEY (TitleId) REFERENCES dbo.Title (TitleId),
        CONSTRAINT FK_Contact_PreferredLanguage
            FOREIGN KEY (PreferredLanguageId) REFERENCES dbo.Language (LanguageId),
        CONSTRAINT FK_Contact_Country
            FOREIGN KEY (CountryId) REFERENCES dbo.Country (CountryId),
        CONSTRAINT FK_Contact_Designation
            FOREIGN KEY (DesignationId) REFERENCES dbo.Designation (DesignationId),
        CONSTRAINT FK_Contact_Department
            FOREIGN KEY (DepartmentId) REFERENCES dbo.Department (DepartmentId),
        CONSTRAINT FK_Contact_ClassificationType
            FOREIGN KEY (ClassificationTypeId) REFERENCES dbo.ClassificationType (ClassificationTypeId),
        CONSTRAINT FK_Contact_ClassificationSegment
            FOREIGN KEY (ClassificationSegmentId) REFERENCES dbo.ClassificationSegment (ClassificationSegmentId),
        CONSTRAINT FK_Contact_ConfidentialityLevel
            FOREIGN KEY (ConfidentialityLevelId) REFERENCES dbo.ConfidentialityLevel (ConfidentialityLevelId),
        CONSTRAINT FK_Contact_ValidationStatus
            FOREIGN KEY (ValidationStatusId) REFERENCES dbo.ValidationStatus (ValidationStatusId),
        CONSTRAINT FK_Contact_ContactOwnerUser
            FOREIGN KEY (ContactOwnerUserId) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_Contact_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_Contact_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_Contact_CountryId'
      AND object_id = OBJECT_ID(N'dbo.Contact')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Contact_CountryId
        ON dbo.Contact (CountryId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_Contact_ContactOwnerUserId'
      AND object_id = OBJECT_ID(N'dbo.Contact')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Contact_ContactOwnerUserId
        ON dbo.Contact (ContactOwnerUserId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_Contact_ClassificationTypeId'
      AND object_id = OBJECT_ID(N'dbo.Contact')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Contact_ClassificationTypeId
        ON dbo.Contact (ClassificationTypeId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_Contact_ValidationStatusId'
      AND object_id = OBJECT_ID(N'dbo.Contact')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Contact_ValidationStatusId
        ON dbo.Contact (ValidationStatusId);
END;
GO
