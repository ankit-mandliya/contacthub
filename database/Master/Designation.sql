IF OBJECT_ID(N'dbo.Designation', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Designation
    (
        DesignationId INT IDENTITY(1,1) NOT NULL,
        DesignationCode NVARCHAR(30) NOT NULL,
        DesignationName NVARCHAR(150) NOT NULL,
        Description NVARCHAR(500) NULL,
        DisplayOrder INT NOT NULL
            CONSTRAINT DF_Designation_DisplayOrder DEFAULT (0),
        IsActive BIT NOT NULL
            CONSTRAINT DF_Designation_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Designation_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Designation_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_Designation PRIMARY KEY CLUSTERED (DesignationId),
        CONSTRAINT CK_Designation_DesignationCode_NotBlank
            CHECK (LEN(LTRIM(RTRIM(DesignationCode))) > 0),
        CONSTRAINT CK_Designation_DesignationName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(DesignationName))) > 0),
        CONSTRAINT CK_Designation_DisplayOrder_NonNegative
            CHECK (DisplayOrder >= 0),
        CONSTRAINT FK_Designation_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_Designation_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Designation_DesignationCode'
      AND object_id = OBJECT_ID(N'dbo.Designation')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Designation_DesignationCode
        ON dbo.Designation (DesignationCode);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Designation_DesignationName'
      AND object_id = OBJECT_ID(N'dbo.Designation')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Designation_DesignationName
        ON dbo.Designation (DesignationName);
END;
GO
