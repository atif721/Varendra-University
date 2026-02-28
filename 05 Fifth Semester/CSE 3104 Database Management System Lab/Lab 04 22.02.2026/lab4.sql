USE Atif
GO

SELECT * FROM WORKER

SELECT 
    WORKER_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY AS SALARY_BDT,
    CONVERT(Decimal(10), SALARY/120) AS SALARY_USD,
    CONVERT(VARCHAR(10), JOINING_DATE, 101) AS JOINING_DATE_FORMATED
FROM WORKER;

-- ==============================
-- 1️⃣ CHECK IF STRING IS A VALID DATE
-- ==============================

SELECT
    ISDATE('2026-02-28') AS ValidDate1,   -- 1 = valid
    ISDATE('31/02/2026') AS ValidDate2;   -- 0 = invalid


-- ==============================
-- 2️⃣ CURRENT DATE & TIME FUNCTIONS
-- ==============================

SELECT
    GETDATE() AS LocalDateTime,
    CURRENT_TIMESTAMP AS CurrentTimestamp,
    SYSDATETIME() AS SysDateTime,
    GETUTCDATE() AS UtcDateTime;


-- ==============================
-- 3️⃣ EXTRACTING DATE PARTS
-- ==============================

SELECT
    DAY(GETDATE()) AS TodayDay,
    DATEPART(MONTH, GETDATE()) AS CurrentMonth,
    DATEPART(YEAR, GETDATE()) AS CurrentYear,
    DATEPART(HOUR, GETDATE()) AS CurrentHour;


-- ==============================
-- 4️⃣ ADDING & DIFFERENCE IN DATES
-- ==============================

-- Add 10 days to current date
SELECT
    DATEADD(DAY, 10, GETDATE()) AS Add10Days;

-- Difference between two dates
SELECT
    DATEDIFF(DAY, '2026-01-01', GETDATE()) AS DaysPassed;


-- ==============================
-- 5️⃣ CAST & CONVERT
-- ==============================

-- CAST example
SELECT
    CAST(GETDATE() AS DATE) AS OnlyDate,
    CAST(GETDATE() AS TIME) AS OnlyTime;

-- CONVERT example (with formatting)
SELECT
    CONVERT(VARCHAR, GETDATE(), 101) AS US_Format,   -- MM/DD/YYYY
    CONVERT(VARCHAR, GETDATE(), 103) AS UK_Format;   -- DD/MM/YYYY


-- ==============================
-- 6️⃣ US vs UK DATE FORMATTING INPUT
-- ==============================

-- US Format (MM/DD/YYYY)
SET DATEFORMAT mdy;
SELECT CAST('02/28/2026' AS DATETIME) AS US_Date;

-- UK Format (DD/MM/YYYY)
SET DATEFORMAT dmy;
SELECT CAST('28/02/2026' AS DATETIME) AS UK_Date;


SELECT
    CONVERT(VARCHAR, GETDATE(), 101) AS US_Format,
    CONVERT(VARCHAR, GETDATE(), 103) AS UK_Format,
    CONVERT(VARCHAR, GETDATE(), 112) AS ISO_Format,
    CONVERT(VARCHAR, GETDATE(), 120) AS ODBC_Format;
