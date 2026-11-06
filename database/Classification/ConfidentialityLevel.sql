IF OBJECT_ID(N'dbo.ConfidentialityLevel', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ConfidentialityLevel
    (
        ConfidentialityLevelId INT IDENTITY(1,1) NOT NULL,
        ConfidentialityLevelName NVARCHAR(100) NOT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_ConfidentialityLevel_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ConfidentialityLevel_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ConfidentialityLevel_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_ConfidentialityLevel
            PRIMARY KEY CLUSTERED (ConfidentialityLevelId),
        CONSTRAINT CK_ConfidentialityLevel_Name_NotBlank
            CHECK (LEN(LTRIM(RTRIM(ConfidentialityLevelName))) > 0),
        CONSTRAINT FK_ConfidentialityLevel_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ConfidentialityLevel_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_ConfidentialityLevel_Name'
      AND object_id = OBJECT_ID(N'dbo.ConfidentialityLevel')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_ConfidentialityLevel_Name
        ON dbo.ConfidentialityLevel (ConfidentialityLevelName);
END;
GO
