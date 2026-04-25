-- CREATE DATABASE Final;

USE Final
Go
-- CREATE TABLE Developers (
--     DevID INT PRIMARY KEY,
--     DevName VARCHAR(100),
--     Department VARCHAR(50),
--     BaseSalary INT,
--     JoinDate DATE,
--     Email VARCHAR(100)
-- );

-- CREATE TABLE Project (
--     ProjectID VARCHAR(5) PRIMARY KEY,
--     ProjectName VARCHAR(100),
--     Client VARCHAR(100),
--     Budget INT,
--     Status VARCHAR(20)
-- );

-- CREATE TABLE ProjectAllocations (
--     AllocID INT PRIMARY KEY,
--     DevID INT,
--     ProjectID VARCHAR(5),
--     AllocHours INT,
--     Role VARCHAR(50),
--     FOREIGN KEY (DevID) REFERENCES Developers(DevID),
--     FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
-- );

-- INSERT INTO Developers VALUES
-- (1, 'Alice Smith', 'Frontend', 55000, '2021-05-10', 'alice@tech.com'),
-- (2, 'Bob Johnson', 'Backend', 72000, '2020-08-15', 'bob@dev.net'),
-- (3, 'Charlie Brown', 'DevOps', 65000, '2022-01-20', 'charlie@tech.com'),
-- (4, 'Diana Prince', 'Backend', 80000, '2019-11-05', 'diana@dev.net'),
-- (5, 'Evan Wright', 'Frontend', 48000, '2023-03-01', 'evan@tech.com'),
-- (6, 'Fiona Gallagher', 'Data Science', 95000, '2018-07-22', 'fiona@data.org'),
-- (7, 'George Lucas', 'Backend', 61000, '2022-09-10', 'george@dev.net'),
-- (8, 'Hannah Abbott', 'DevOps', 68000, '2021-12-12', 'hannah@tech.com'),
-- (9, 'Ian Somerhalder', 'Frontend', 52000, '2022-05-30', 'ian@tech.com'),
-- (10, 'Jane Doe', 'Data Science', 89000, '2020-02-18', 'jane@data.org');

-- INSERT INTO Project VALUES
-- ('P1', 'Project Alpha', 'TechCorp', 500000, 'Active'),
-- ('P2', 'Project Beta', 'HealthInc', 300000, 'Active'),
-- ('P3', 'Project Gamma', 'FinBank', 750000, 'Completed'),
-- ('P4', 'Project Delta', 'EduNet', 200000, 'Active');

-- INSERT INTO ProjectAllocations VALUES
-- (101, 2, 'P1', 120, 'Lead'),
-- (102, 1, 'P1', 80, 'Developer'),
-- (103, 4, 'P2', 150, 'Lead'),
-- (104, 6, 'P3', 200, 'Data Architect'),
-- (105, 3, 'P1', 100, 'Ops Manager'),
-- (106, 7, 'P2', 90, 'Developer'),
-- (107, 10, 'P3', 180, 'Analyst'),
-- (108, 5, 'P4', 60, 'UI/UX'),
-- (109, 8, 'P2', 110, 'Ops Manager'),
-- (110, 9, 'P4', 70, 'Developer');

-- SELECT *
-- FROM Developers

-- SELECT *
-- FROM Project

-- SELECT *
-- FROM ProjectAllocations

-- Question-1
-- UPDATE Developers
-- SET BaseSalary = BaseSalary * 1.15
-- WHERE Department = 'Backend'
--   AND JoinDate < '2022-01-01'
--   AND BaseSalary * 1.15 <=85000

-- SELECT BaseSalary
-- FROM Developers
-- WHERE Department = 'Backend'
--   AND JoinDate < '2022-01-01'

-- Question-2
-- SELECT
--   UPPER(DevName) AS DevNamesUpper,
--   LEN(Email) AS DevEmailLength,
--   DATEDIFF(MONTH, JoinDate, GETDATE()) AS TotalEmplpoyed
-- FROM Developers
-- WHERE DATEDIFF(MONTH, JoinDate, GETDATE()) > 24

-- Question-3
-- SELECT d.DevName, d.Department, d.BaseSalary
-- FROM Developers d
-- ORDER BY BaseSalary DESC;

-- Question-4
-- SELECT
--   p.ProjectID,
--   COUNT(d.DevID) AS TotalDevelopers,
--   SUM(pa.AllocHours) AS TotalAllocHours
-- FROM Developers d
--   JOIN ProjectAllocations pa ON pa.DevID = d.DevID
--   JOIN Project p ON p.ProjectID = pa.ProjectID
-- GROUP BY p.ProjectID
-- HAVINg SUM(pa.AllocHours)>150
-- ORDER BY TotalAllocHours DESC

-- Question-5
-- ALTER TABLE Developers
-- ADD CONSTRAINT UniqueDevMail UNIQUE(Email);
-- ALTER TABLE Developers
-- ADD CONSTRAINT CheckBaseSalary CHECK(BaseSalary>45000)

SELECT *
FROM Developers