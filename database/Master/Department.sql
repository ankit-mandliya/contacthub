IF OBJECT_ID(N'dbo.Department', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Department
    (
        DepartmentId INT IDENTITY(1,1) NOT NULL,
        DepartmentCode NVARCHAR(30) NOT NULL,
        DepartmentName NVARCHAR(150) NOT NULL,
        Description NVARCHAR(500) NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_Department_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Department_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Department_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_Department PRIMARY KEY CLUSTERED (DepartmentId),
        CONSTRAINT CK_Department_DepartmentCode_NotBlank
            CHECK (LEN(LTRIM(RTRIM(DepartmentCode))) > 0),
        CONSTRAINT CK_Department_DepartmentName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(DepartmentName))) > 0),
        CONSTRAINT FK_Department_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_Department_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Department_DepartmentCode'
      AND object_id = OBJECT_ID(N'dbo.Department')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Department_DepartmentCode
        ON dbo.Department (DepartmentCode);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Department_DepartmentName'
      AND object_id = OBJECT_ID(N'dbo.Department')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Department_DepartmentName
        ON dbo.Department (DepartmentName);
END;
GO
