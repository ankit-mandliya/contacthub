IF OBJECT_ID(N'dbo.ContactGroup', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ContactGroup
    (
        ContactId INT NOT NULL,
        GroupId INT NOT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_ContactGroup_IsActive DEFAULT (1),
        CreatedBy INT NULL,
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactGroup_CreatedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ContactGroup_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        CONSTRAINT PK_ContactGroup PRIMARY KEY CLUSTERED (ContactId, GroupId),
        CONSTRAINT FK_ContactGroup_Contact
            FOREIGN KEY (ContactId) REFERENCES dbo.Contact (ContactId),
        CONSTRAINT FK_ContactGroup_Group
            FOREIGN KEY (GroupId) REFERENCES dbo.GroupMaster (GroupId),
        CONSTRAINT FK_ContactGroup_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ContactGroup_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactGroup_GroupId'
      AND object_id = OBJECT_ID(N'dbo.ContactGroup')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactGroup_GroupId
        ON dbo.ContactGroup (GroupId);
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_ContactGroup_ContactId'
      AND object_id = OBJECT_ID(N'dbo.ContactGroup')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_ContactGroup_ContactId
        ON dbo.ContactGroup (ContactId);
END;
GO
