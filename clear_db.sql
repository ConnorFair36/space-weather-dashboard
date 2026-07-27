TRUNCATE TABLE stg_CME_Raw;
-- Step 1: Drop the relationship
ALTER TABLE CME_Analysis DROP CONSTRAINT FK__CME_Analy__activ__17F790F9;

-- Step 2: Truncate your target table
TRUNCATE TABLE CME_Events;
TRUNCATE TABLE CME_Analysis;

-- Step 3: Re-create the relationship
ALTER TABLE CME_Analysis 
ADD CONSTRAINT FK__CME_Analy__activ__17F790F9 
FOREIGN KEY (activityID) REFERENCES CME_Events(activityID)
