IF OBJECT_ID(N'dbo.GroupMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.GroupMaster
    (
        GroupId INT IDENTITY(1,1) NOT NULL,
        GroupCode NVARCHAR(30) NOT NULL,
        GroupName NVARCHAR(150) NOT NULL,
        Description NVARCHAR(500) NULL,
        DisplayOrder INT NOT NULL
            CONSTRAINT DF_GroupMaster_DisplayOrder DEFAULT (0),
        IsActive BIT NOT NULL
            CONSTRAINT DF_GroupMaster_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_GroupMaster_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_GroupMaster_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_GroupMaster PRIMARY KEY CLUSTERED (GroupId),
        CONSTRAINT CK_GroupMaster_GroupCode_NotBlank
            CHECK (LEN(LTRIM(RTRIM(GroupCode))) > 0),
        CONSTRAINT CK_GroupMaster_GroupName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(GroupName))) > 0),
        CONSTRAINT CK_GroupMaster_DisplayOrder_NonNegative
            CHECK (DisplayOrder >= 0),
        CONSTRAINT FK_GroupMaster_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_GroupMaster_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_GroupMaster_GroupCode'
      AND object_id = OBJECT_ID(N'dbo.GroupMaster')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_GroupMaster_GroupCode
        ON dbo.GroupMaster (GroupCode);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_GroupMaster_GroupName'
      AND object_id = OBJECT_ID(N'dbo.GroupMaster')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_GroupMaster_GroupName
        ON dbo.GroupMaster (GroupName);
END;
GO
