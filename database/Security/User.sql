IF OBJECT_ID(N'dbo.[User]', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.[User]
    (
        UserId INT IDENTITY(1,1) NOT NULL,
        UserName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(320) NOT NULL,
        DisplayName NVARCHAR(200) NOT NULL,
        PasswordHash NVARCHAR(512) NOT NULL,
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_User_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_User_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_User_IsActive DEFAULT (1),
        CONSTRAINT PK_User PRIMARY KEY CLUSTERED (UserId),
        CONSTRAINT CK_User_UserName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(UserName))) > 0),
        CONSTRAINT CK_User_Email_NotBlank
            CHECK (LEN(LTRIM(RTRIM(Email))) > 0),
        CONSTRAINT CK_User_DisplayName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(DisplayName))) > 0),
        CONSTRAINT CK_User_PasswordHash_NotBlank
            CHECK (LEN(LTRIM(RTRIM(PasswordHash))) > 0),
        CONSTRAINT FK_User_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_User_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_User_UserName'
      AND object_id = OBJECT_ID(N'dbo.[User]')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_User_UserName
        ON dbo.[User] (UserName);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_User_Email'
      AND object_id = OBJECT_ID(N'dbo.[User]')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_User_Email
        ON dbo.[User] (Email);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_Role_CreatedBy'
      AND parent_object_id = OBJECT_ID(N'dbo.Role')
)
BEGIN
    ALTER TABLE dbo.Role
        ADD CONSTRAINT FK_Role_CreatedBy
        FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_Role_ModifiedBy'
      AND parent_object_id = OBJECT_ID(N'dbo.Role')
)
BEGIN
    ALTER TABLE dbo.Role
        ADD CONSTRAINT FK_Role_ModifiedBy
        FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId);
END;
GO
