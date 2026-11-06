IF OBJECT_ID(N'dbo.Role', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Role
    (
        RoleId INT IDENTITY(1,1) NOT NULL,
        RoleName NVARCHAR(100) NOT NULL,
        Description NVARCHAR(500) NULL,
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Role_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_Role_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_Role_IsActive DEFAULT (1),
        CONSTRAINT PK_Role PRIMARY KEY CLUSTERED (RoleId),
        CONSTRAINT CK_Role_RoleName_NotBlank
            CHECK (LEN(LTRIM(RTRIM(RoleName))) > 0)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_Role_RoleName'
      AND object_id = OBJECT_ID(N'dbo.Role')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_Role_RoleName
        ON dbo.Role (RoleName);
END;
GO
