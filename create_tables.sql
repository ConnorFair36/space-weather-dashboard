-- creates the table if it doesn't already exist
IF OBJECT_ID(N'dbo.stg_CME_Raw', N'U') IS NULL
BEGIN
    CREATE TABLE stg_CME_Raw (
        activityID          NVARCHAR(50),
        catalog              NVARCHAR(50),
        eventStartTime       DATETIME2,
        sourceLocation       NVARCHAR(50) NULL,
        activeRegionNum      INT NULL,
        eventNote            NVARCHAR(MAX),
        eventSubmissionTime  DATETIME2,
        versionId            INT,
        eventLink            NVARCHAR(400),
        isMostAccurate       BIT,
        time21_5             DATETIME2 NULL,
        latitude             FLOAT NULL,
        longitude            FLOAT NULL,
        halfAngle            FLOAT NULL,
        speed                FLOAT NULL,
        type                 NVARCHAR(10),
        analysisNote         NVARCHAR(MAX),
        levelOfData          INT NULL,
        analysisSubmissionTime DATETIME2,
        analysisLink         NVARCHAR(400)
    );
END;

IF OBJECT_ID(N'dbo.CME_Events', N'U') IS NULL
BEGIN
    CREATE TABLE CME_Events (
        activityID          NVARCHAR(50) PRIMARY KEY,
        catalog              NVARCHAR(50),
        eventStartTime       DATETIME2,
        sourceLocation       NVARCHAR(50) NULL,
        activeRegionNum      INT NULL,
        eventNote            NVARCHAR(MAX),
        eventSubmissionTime  DATETIME2,
        versionId            INT,
        eventLink            NVARCHAR(400),
    );
END;

IF OBJECT_ID(N'dbo.CME_Analysis', N'U') IS NULL
BEGIN
    CREATE TABLE CME_Analysis (
        analysisID INT IDENTITY(1,1) PRIMARY KEY,
        activityID          NVARCHAR(50),
        isMostAccurate       BIT,
        time21_5             DATETIME2 NULL,
        latitude             FLOAT NULL,
        longitude            FLOAT NULL,
        halfAngle            FLOAT NULL,
        speed                FLOAT NULL,
        type                 NVARCHAR(10),
        analysisNote         NVARCHAR(MAX),
        levelOfData          INT NULL,
        analysisSubmissionTime DATETIME2,
        analysisLink         NVARCHAR(400),
        FOREIGN KEY (activityID) REFERENCES CME_Events(activityID)
    );
END;