IF OBJECT_ID(N'dbo.UserRole', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.UserRole
    (
        UserId INT NOT NULL,
        RoleId INT NOT NULL,
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_UserRole_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_UserRole_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_UserRole_IsActive DEFAULT (1),
        CONSTRAINT PK_UserRole PRIMARY KEY CLUSTERED (UserId, RoleId),
        CONSTRAINT FK_UserRole_User
            FOREIGN KEY (UserId) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_UserRole_Role
            FOREIGN KEY (RoleId) REFERENCES dbo.Role (RoleId),
        CONSTRAINT FK_UserRole_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_UserRole_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_UserRole_RoleId_UserId'
      AND object_id = OBJECT_ID(N'dbo.UserRole')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_UserRole_RoleId_UserId
        ON dbo.UserRole (RoleId, UserId);
END;
GO
