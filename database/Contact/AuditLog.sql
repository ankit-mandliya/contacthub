IF OBJECT_ID(N'dbo.AuditLog', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.AuditLog
    (
        AuditLogId INT IDENTITY(1,1) NOT NULL,
        EventType NVARCHAR(100) NOT NULL,
        ModuleName NVARCHAR(100) NOT NULL,
        EntityName NVARCHAR(100) NOT NULL,
        EntityId INT NOT NULL,
        PerformedByUserId INT NULL,
        PerformedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_AuditLog_PerformedOn DEFAULT (SYSUTCDATETIME()),
        OldValue NVARCHAR(1000) NULL,
        NewValue NVARCHAR(1000) NULL,
        Source NVARCHAR(100) NULL,
        IPAddress NVARCHAR(45) NULL,
        Remarks NVARCHAR(1000) NULL,
        CONSTRAINT PK_AuditLog PRIMARY KEY CLUSTERED (AuditLogId),
        CONSTRAINT CK_AuditLog_EventType_NotBlank
            CHECK (LEN(LTRIM(RTRIM(EventType))) > 0),
        CONSTRAINT CK_AuditLog_ModuleName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(ModuleName))) > 0),
        CONSTRAINT CK_AuditLog_EntityName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(EntityName))) > 0),
        CONSTRAINT FK_AuditLog_PerformedByUser
            FOREIGN KEY (PerformedByUserId) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_AuditLog_PerformedByUserId'
      AND object_id = OBJECT_ID(N'dbo.AuditLog')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_AuditLog_PerformedByUserId
        ON dbo.AuditLog (PerformedByUserId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_AuditLog_PerformedOn'
      AND object_id = OBJECT_ID(N'dbo.AuditLog')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_AuditLog_PerformedOn
        ON dbo.AuditLog (PerformedOn);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_AuditLog_ModuleName'
      AND object_id = OBJECT_ID(N'dbo.AuditLog')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_AuditLog_ModuleName
        ON dbo.AuditLog (ModuleName);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_AuditLog_EntityName_EntityId'
      AND object_id = OBJECT_ID(N'dbo.AuditLog')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_AuditLog_EntityName_EntityId
        ON dbo.AuditLog (EntityName, EntityId);
END;
GO
