-- VS Code warning can be ignored - query works fine;
-- Step-1. Create Database;
CREATE DATABASE ThirdLab;
-- Step-2. Select the Database;
USE ThirdLab
GO;
-- Step3. Create Table;
CREATE TABLE Worker
(
  WorkerId INT PRIMARY KEY,
  FirstName VARCHAR(50) UNIQUE,
  LastName VARCHAR(50),
  Salary INT,
  CHECK (Salary > 100),
  DepartmentName VARCHAR(8),
  JoiningDate DATETIME
);
-- Step-4. Insert Data;
INSERT INTO Worker
  (
  WorkerId,
  FirstName,
  LastName,
  Salary,
  DepartmentName,
  JoiningDate
  )
VALUES
  (
    1,
    'Rana',
    'Hamid',
    100000,
    'HR',
    '2014-02-20 09:00:00'
  ),
  (
    2,
    'Sanjoy',
    'Saha',
    80000,
    'Admin',
    '2014-06-11 09:00:00'
  ),
  (
    3,
    'Mahmudul',
    'Hasan',
    300000,
    'HR',
    '2014-02-20 09:00:00'
  ),
  (
    4,
    'Asad',
    'Zaman',
    500000,
    'Admin',
    '2014-02-20 09:00:00'
  ),
  (
    5,
    'Sajib',
    'Mia',
    500000,
    'Admin',
    '2014-06-11 09:00:00'
  ),
  (
    6,
    'Alamgir',
    'Kabir',
    200000,
    'Account',
    '2014-06-11 09:00:00'
  ),
  (
    7,
    'Foridul',
    'Islam',
    75000,
    'Account',
    '2014-01-20 09:00:00'
  ),
  (
    8,
    'Kesob',
    'Ray',
    90000,
    'Admin',
    '2014-04-11 09:00:00'
  );
SELECT *
FROM Worker;
-- After doing steps running queries
-- Queries
-- 1;
SELECT *
FROM Worker;
-- 2,3;
SELECT TOP 5
  CONCAT (FirstName, ' ', LastName) AS FullName,
  *
FROM Worker
ORDER BY WorkerId;
-- 4;
SELECT *
FROM Worker
WHERE DepartmentName = 'Admin';
-- 5;
SELECT FirstName,
  LastName,
  Salary
FROM Worker
WHERE Salary > 10000;
-- 6;
SELECT *
FROM Worker
SELECT FirstName,
  Salary
FROM Worker
WHERE Salary > (
    SELECT Salary
FROM Worker
WHERE FirstName = 'Sanjoy'
  );
-- 7;
UPDATE Worker
SET Salary = 95000
WHERE WorkerId = 8;
SELECT *
FROM Worker;
-- 8;
SELECT *
FROM Worker
WHERE WorkerId = 4
SELECT *
FROM Worker
WHERE FirstName = 'Asad'
DELETE FROM Worker
WHERE FirstName = 'Asad'
SELECT *
FROM Worker;