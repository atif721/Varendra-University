-- Practice Sheet on Indexing and Cascading
-- MSSQL Syntax

-- =========================
-- SAMPLE TABLE: Worker
-- =========================

CREATE TABLE Worker
(
  WORKER_ID INT PRIMARY KEY,
  FIRST_NAME VARCHAR(50),
  LAST_NAME VARCHAR(50),
  SALARY INT,
  JOINING_DATE DATETIME,
  DEPARTMENT VARCHAR(50)
);
GO

INSERT INTO Worker
VALUES
  (1, 'Rana', 'Hamid', 100000, '2014-02-20 09:00:00', 'HR'),
  (2, 'Sanjoy', 'Saha', 80000, '2014-06-11 09:00:00', 'Admin'),
  (3, 'Mahmudul', 'Hasan', 300000, '2014-02-20 09:00:00', 'HR'),
  (4, 'Asad', 'Zaman', 500000, '2014-02-20 09:00:00', 'Admin'),
  (5, 'Sajib', 'Mia', 500000, '2014-06-11 09:00:00', 'Admin'),
  (6, 'Alamgir', 'Kabir', 200000, '2014-06-11 09:00:00', 'Account'),
  (7, 'Foridul', 'Islam', 75000, '2014-01-20 09:00:00', 'Account'),
  (8, 'Keshob', 'Ray', 90000, '2014-04-11 09:00:00', 'Admin');
GO

-- =========================
-- PART 1: INDEXING
-- =========================
-- 1. Non-unique index on SALARY
CREATE INDEX idx_worker_salary
ON Worker(SALARY);
GO

-- 2. Composite index on FIRST_NAME and DEPARTMENT
CREATE INDEX idx_name_dept
ON Worker(FIRST_NAME, DEPARTMENT);
GO

-- 3. Unique index on WORKER_ID
CREATE UNIQUE INDEX idx_worker_id_unique
ON Worker(WORKER_ID);
GO

-- 4. Delete index idx_worker_salary
DROP INDEX idx_worker_salary
ON Worker;
GO


-- -- extra
-- CREATE NONCLUSTERED INDEX idx_salary
-- ON Worker(SALARY);
-- SELECT *
-- FROM Worker
-- WHERE SALARY = 500000;

-- -- 1
-- CREATE NONCLUSTERED INDEX idx_worker_name
-- ON Worker(FIRST_NAME);
-- SELECT *
-- FROM Worker
-- WHERE FIRST_NAME = 'Rana';

-- -- 2
-- CREATE NONCLUSTERED INDEX idx_salary_desc
-- ON Worker(SALARY DESC);
-- CREATE NONCLUSTERED INDEX idx_salary_desc
-- ON Worker(SALARY DESC);

-- DROP INDEX idx_name_department
-- ON Worker;