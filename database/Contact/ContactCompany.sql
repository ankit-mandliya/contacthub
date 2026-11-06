IF OBJECT_ID(N'dbo.ContactCompany', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ContactCompany
    (
        ContactCompanyId INT IDENTITY(1,1) NOT NULL,
        ContactId INT NOT NULL,
        CompanyName NVARCHAR(200) NOT NULL,
        JobTitle NVARCHAR(150) NULL,
        DesignationId INT NULL,
        DepartmentId INT NULL,
        StartDate DATE NULL,
        EndDate DATE NULL,
        IsCurrent BIT NOT NULL
            CONSTRAINT DF_ContactCompany_IsCurrent DEFAULT (0),
        IsActive BIT NOT NULL
            CONSTRAINT DF_ContactCompany_IsActive DEFAULT (1),
        CreatedBy INT NULL,
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactCompany_CreatedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactCompany_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        CONSTRAINT PK_ContactCompany PRIMARY KEY CLUSTERED (ContactCompanyId),
        CONSTRAINT CK_ContactCompany_CompanyName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(CompanyName))) > 0),
        CONSTRAINT CK_ContactCompany_DateRange
            CHECK (EndDate IS NULL OR StartDate IS NULL OR EndDate >= StartDate),
        CONSTRAINT FK_ContactCompany_Contact
            FOREIGN KEY (ContactId) REFERENCES dbo.Contact (ContactId),
        CONSTRAINT FK_ContactCompany_Designation
            FOREIGN KEY (DesignationId) REFERENCES dbo.Designation (DesignationId),
        CONSTRAINT FK_ContactCompany_Department
            FOREIGN KEY (DepartmentId) REFERENCES dbo.Department (DepartmentId),
        CONSTRAINT FK_ContactCompany_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ContactCompany_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactCompany_ContactId'
      AND object_id = OBJECT_ID(N'dbo.ContactCompany')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactCompany_ContactId
        ON dbo.ContactCompany (ContactId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactCompany_CompanyName'
      AND object_id = OBJECT_ID(N'dbo.ContactCompany')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactCompany_CompanyName
        ON dbo.ContactCompany (CompanyName);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactCompany_IsCurrent'
      AND object_id = OBJECT_ID(N'dbo.ContactCompany')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactCompany_IsCurrent
        ON dbo.ContactCompany (IsCurrent);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactCompany_StartDate'
      AND object_id = OBJECT_ID(N'dbo.ContactCompany')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactCompany_StartDate
        ON dbo.ContactCompany (StartDate);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_ContactCompany_ActiveContact'
      AND object_id = OBJECT_ID(N'dbo.ContactCompany')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_ContactCompany_ActiveContact
        ON dbo.ContactCompany (ContactId)
        WHERE IsCurrent = 1;
END;
GO
