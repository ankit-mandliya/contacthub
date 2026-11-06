IF OBJECT_ID(N'dbo.ClassificationType', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ClassificationType
    (
        ClassificationTypeId INT IDENTITY(1,1) NOT NULL,
        ClassificationTypeName NVARCHAR(100) NOT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_ClassificationType_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ClassificationType_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ClassificationType_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_ClassificationType
            PRIMARY KEY CLUSTERED (ClassificationTypeId),
        CONSTRAINT CK_ClassificationType_Name_NotBlank
            CHECK (LEN(LTRIM(RTRIM(ClassificationTypeName))) > 0),
        CONSTRAINT FK_ClassificationType_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ClassificationType_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_ClassificationType_Name'
      AND object_id = OBJECT_ID(N'dbo.ClassificationType')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_ClassificationType_Name
        ON dbo.ClassificationType (ClassificationTypeName);
END;
GO
