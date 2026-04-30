USE Atif
GO 

-- CREATE TABLE STUDENT (
--     Student_ID INT PRIMARY KEY,
--     Name VARCHAR(50),
--     Department VARCHAR(10),
--     CGPA DECIMAL(3, 2),
--     Admission_Year INT
-- );

-- CREATE TABLE COURSE (
--     Course_ID VARCHAR(10) PRIMARY KEY,
--     Course_Name VARCHAR(100),
--     Credit INT,
--     Instructor VARCHAR(50),
--     Department VARCHAR(10)
-- );

-- INSERT INTO STUDENT (Student_ID, Name, Department, CGPA, Admission_Year) VALUES
-- (101, 'Rafiq', 'CSE', 3.75, 2021),
-- (102, 'Nabila', 'EEE', 3.60, 2020),
-- (103, 'Hasan', 'CSE', 3.90, 2019),
-- (104, 'Tania', 'BBA', 3.40, 2022),
-- (105, 'Reza', 'EEE', 3.10, 2021);

-- INSERT INTO COURSE (Course_ID, Course_Name, Credit, Instructor, Department) VALUES
-- ('C101', 'Database Systems', 3, 'Dr. Karim', 'CSE'),
-- ('C102', 'Circuit Theory', 3, 'Dr. Rahman', 'EEE'),
-- ('C103', 'Marketing Basics', 2, 'Dr. Jahan', 'BBA'),
-- ('C104', 'Computer Networks', 3, 'Dr. Alam', 'CSE'),
-- ('C105', 'Control Systems', 3, 'Dr. Rahman', 'EEE');


-- Question-1
SELECT
st.Department ,
AVG(st.CGPA) AS AverageCgpa
FROM STUDENT st
GROUP BY st.Department

-- Question-2
SELECT DISTINCT(st.Department)
FROM STUDENT st;

-- Question-3
SELECT st.Student_ID, st.Name, st.Department
FROM STUDENT st
 JOIN COURSE cr ON cr.Department = st.Department

-- Question-4
SELECT cr.Instructor, cr.Department, SUM(Credit) AS TotalCredit
FROM COURSE cr
GROUP BY cr.Department, cr.Instructor
ORDER BY SUM(Credit) DESC
OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY

-- Question-5
-- SELECT Department, SUM(Credit) AS CreditHours
-- FROM COURSE
-- GROUP BY Department, Credit
-- HAVING SUM(Credit) = SELECT SUM(Credit)