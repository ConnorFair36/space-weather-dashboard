SELECT *
FROM CME_Analysis;

SELECT *
FROM CME_Events;

SELECT *
FROM stg_CME_Raw;

/*
SELECT t1.*
FROM CME_Analysis AS t1
INNER JOIN CME_Analysis AS t2 ON 
    t1.activityID = t2.activityID AND
    t1.isMostAccurate = t2.isMostAccurate AND
    t1.time21_5 = t2.time21_5 AND
    t1.latitude = t2.latitude AND
    t1.longitude = t2.longitude AND
    t1.halfAngle = t2.halfAngle AND
    t1.speed = t2.speed AND
    t1.type = t2.type AND
    t1.analysisNote = t2.analysisNote AND
    t1.levelOfData = t2.levelOfData AND
    t1.analysisSubmissionTime = t2.analysisSubmissionTime AND
    t1.analysisLink = t2.analysisLink
WHERE 
    t1.analysisID < t2.analysisID
*/

/*
SELECT 
    OBJECT_NAME(parent_object_id) AS ChildTable,
    name AS ConstraintName
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('CME_Events');
*/