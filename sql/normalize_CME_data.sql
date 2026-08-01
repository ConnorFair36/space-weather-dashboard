CREATE PROCEDURE normalize_CME_data AS 
BEGIN
    -- 2 steps: update existing records, add new records
    WITH new_CME_Events AS (
        SELECT DISTINCT
            activityID,
            catalog,
            eventStartTime,
            sourceLocation,
            activeRegionNum,
            eventNote,
            eventSubmissionTime,
            versionId,
            eventLink
        FROM stg_CME_Raw
    )

    -- Updates existing values with new values
    UPDATE CME_Events
    SET 
        CME_Events.activityID = new_CME_Events.activityID,
        CME_Events.catalog = new_CME_Events.catalog,
        CME_Events.eventStartTime = new_CME_Events.eventStartTime,
        CME_Events.sourceLocation = new_CME_Events.sourceLocation,
        CME_Events.activeRegionNum = new_CME_Events.activeRegionNum,
        CME_Events.eventNote = new_CME_Events.eventNote,
        CME_Events.eventSubmissionTime = new_CME_Events.eventSubmissionTime,
        CME_Events.versionId = new_CME_Events.versionId,
        CME_Events.eventLink = new_CME_Events.eventLink
    FROM CME_Events
    INNER JOIN new_CME_Events
        ON CME_Events.activityID = new_CME_Events.activityID;

    -- inserts the new raw CME data into each table
    WITH new_CME_Events AS (
        SELECT DISTINCT
            activityID,
            catalog,
            eventStartTime,
            sourceLocation,
            activeRegionNum,
            eventNote,
            eventSubmissionTime,
            versionId,
            eventLink
        FROM stg_CME_Raw
    )

    INSERT INTO CME_Events
    SELECT new_CME_Events.*
    FROM new_CME_Events
    LEFT JOIN CME_Events ON 
        new_CME_Events.activityID = CME_Events.activityID
    WHERE
        CME_Events.activityID IS NULL;

    -- 2 steps: delete analysis that connect to events that are coming in today and add all the new records
    WITH new_CME_Analysis as (
        SELECT
            activityID,
            isMostAccurate,
            time21_5,
            latitude,
            longitude,
            halfAngle,
            speed,
            type,
            analysisNote,
            levelOfData,
            analysisSubmissionTime,
            analysisLink
        FROM stg_CME_Raw
    )

    -- Delete existing analysis that exist for the new events
    DELETE FROM CME_Analysis
    WHERE CME_Analysis.activityID IN (SELECT activityID FROM new_CME_Analysis);

    -- inserts the new raw CME data into each table
    WITH new_CME_Analysis as (
        SELECT
            activityID,
            isMostAccurate,
            time21_5,
            latitude,
            longitude,
            halfAngle,
            speed,
            type,
            analysisNote,
            levelOfData,
            analysisSubmissionTime,
            analysisLink
        FROM stg_CME_Raw
    )
    INSERT INTO CME_Analysis
    SELECT new_CME_Analysis.*
    FROM new_CME_Analysis
    LEFT JOIN CME_Analysis ON 
        new_CME_Analysis.activityID = CME_Analysis.activityID
    WHERE
        CME_Analysis.activityID IS NULL;

    -- clear out the raw data table, everything should be copied from there by now
    TRUNCATE TABLE stg_CME_Raw;
END;