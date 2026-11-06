IF OBJECT_ID(N'dbo.ClassificationSegment', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ClassificationSegment
    (
        ClassificationSegmentId INT IDENTITY(1,1) NOT NULL,
        ClassificationSegmentName NVARCHAR(100) NOT NULL,
        IsActive BIT NOT NULL
            CONSTRAINT DF_ClassificationSegment_IsActive DEFAULT (1),
        CreatedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ClassificationSegment_CreatedOn DEFAULT (SYSUTCDATETIME()),
        CreatedBy INT NULL,
        ModifiedOn DATETIME2(3) NOT NULL
            CONSTRAINT DF_ClassificationSegment_ModifiedOn DEFAULT (SYSUTCDATETIME()),
        ModifiedBy INT NULL,
        CONSTRAINT PK_ClassificationSegment
            PRIMARY KEY CLUSTERED (ClassificationSegmentId),
        CONSTRAINT CK_ClassificationSegment_Name_NotBlank
            CHECK (LEN(LTRIM(RTRIM(ClassificationSegmentName))) > 0),
        CONSTRAINT FK_ClassificationSegment_CreatedBy
            FOREIGN KEY (CreatedBy) REFERENCES dbo.[User] (UserId),
        CONSTRAINT FK_ClassificationSegment_ModifiedBy
            FOREIGN KEY (ModifiedBy) REFERENCES dbo.[User] (UserId)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'UX_ClassificationSegment_Name'
      AND object_id = OBJECT_ID(N'dbo.ClassificationSegment')
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_ClassificationSegment_Name
        ON dbo.ClassificationSegment (ClassificationSegmentName);
END;
GO
