IF OBJECT_ID(N'dbo.ValidationStatus', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ValidationStatus
    (
        ValidationStatusId INT IDENTITY(1,1) NOT NULL,
        ValidationStatusName NVARCHAR(100) NOT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_ValidationStatus_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ValidationStatus_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ValidationStatus_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_ValidationStatus
            PRIMARY KEY CLUSTERED (ValidationStatusId),
        CONSTRAINT CK_ValidationStatus_Name_NotBlank
            CHECK (LEN(LTRIM(RTRIM(ValidationStatusName))) > 0),
        CONSTRAINT FK_ValidationStatus_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ValidationStatus_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_ValidationStatus_Name'
      AND object_id = OBJECT_ID(N'dbo.ValidationStatus')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_ValidationStatus_Name
        ON dbo.ValidationStatus (ValidationStatusName);
END;
GO
