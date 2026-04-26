-- =====================================================
-- PRACTICE SET 02
-- Database Management System Lab
-- Mid Term Practice Questions
-- =====================================================

-- SCENARIO: HOSPITAL MANAGEMENT SYSTEM

-- TABLE: Doctors
-- +------------+----------------+---------------+-------------+--------------+------------+
-- | DoctorID   | Name           | Specialization| Experience  | ConsultationFee| Phone    |
-- +------------+----------------+---------------+-------------+--------------+------------+
-- | D001       | Dr. Ahmed      | Cardiology    | 15          | 1500.00      | 01711-111111 |
-- | D002       | Dr. Begum      | Dermatology   | 8           | 1000.00      | 01711-222222 |
-- | D003       | Dr. Chowdhury  | Neurology     | 20          | 2000.00      | 01711-333333 |
-- | D004       | Dr. Das        | Orthopedics   | 12          | 1200.00      | 01711-444444 |
-- | D005       | Dr. Rahman     | Cardiology    | 10          | 1400.00      | 01711-555555 |
-- | D006       | Dr. Sultana    | Pediatrics    | 6           | 900.00       | 01711-666666 |
-- | D007       | Dr. Khan       | General       | 5           | 500.00       | 01711-777777 |
-- | D008       | Dr. Islam      | Dermatology   | 14          | 1100.00      | 01711-888888 |
-- +------------+----------------+---------------+-------------+--------------+------------+

-- TABLE: Patients
-- +------------+----------------+---------------+------------+--------+--------------+
-- | PatientID  | Name           | Phone         | BirthDate  | Gender | Address      |
-- +------------+----------------+---------------+------------+--------+--------------+
-- | P001       | Karim Hassan   | 01811-111111  | 1985-03-15 | Male   | Dhaka        |
-- | P002       | Salma Khatun   | 01811-222222  | 1990-07-22 | Female | Chittagong   |
-- | P003       | Rahim Uddin    | 01811-333333  | 1978-11-30 | Male   | Sylhet       |
-- | P004       | Nasrin Akter   | 01811-444444  | 1995-01-08 | Female | Rajshahi     |
-- | P005       | Jamal Hossain  | 01811-555555  | 1982-06-14 | Male   | Dhaka        |
-- | P006       | Ruma Begum     | 01811-666666  | 2000-09-25 | Female | Khulna       |
-- | P007       | Kamal Mia      | 01811-777777  | 1975-12-03 | Male   | Barisal      |
-- | P008       | Ayesha Siddika | 01811-888888  | 1988-04-17 | Female | Dhaka        |
-- | P009       | Sohel Rana     | 01811-999999  | 1992-08-21 | Male   | Rangpur      |
-- +------------+----------------+---------------+------------+--------+--------------+

-- TABLE: Appointments
-- +------------+------------+------------+-------------+------------+---------------+
-- | ApptID     | DoctorID   | PatientID  | ApptDate    | ApptTime   | Status        |
-- +------------+------------+------------+-------------+------------+---------------+
-- | A001       | D001       | P001       | 2024-04-01  | 10:00      | Completed     |
-- | A002       | D002       | P002       | 2024-04-01  | 11:00      | Completed     |
-- | A003       | D003       | P003       | 2024-04-02  | 09:00      | Completed     |
-- | A004       | D001       | P004       | 2024-04-02  | 14:00      | Cancelled     |
-- | A005       | D004       | P005       | 2024-04-03  | 10:30      | Completed     |
-- | A006       | D005       | P001       | 2024-04-05  | 15:00      | Completed     |
-- | A007       | D006       | P006       | 2024-04-08  | 11:30      | Scheduled     |
-- | A008       | D007       | P007       | 2024-04-10  | 09:30      | Scheduled     |
-- | A009       | D001       | P008       | 2024-04-10  | 10:00      | Scheduled     |
-- | A010       | D002       | P009       | 2024-04-10  | 14:00      | Scheduled     |
-- | A011       | D003       | P002       | 2024-04-12  | 10:00      | Scheduled     |
-- | A012       | D004       | P003       | 2024-04-03  | 15:30      | Completed     |
-- | A013       | D008       | P004       | 2024-04-15  | 11:00      | Scheduled     |
-- | A014       | D005       | P005       | 2024-04-06  | 09:00      | Completed     |
-- +------------+------------+------------+-------------+------------+---------------+

-- =====================================================
-- QUESTIONS (1-15)
-- =====================================================

USE Final
Go

CREATE TABLE Doctors
(
  DoctorID VARCHAR(10) PRIMARY KEY,
  Name VARCHAR(50),
  Specialization VARCHAR(50),
  Experience INT,
  ConsultationFee DECIMAL(10,2),
  Phone VARCHAR(20)
)

CREATE TABLE Patients
(
  PatientID VARCHAR(10) PRIMARY KEY,
  Name VARCHAR(50),
  Phone VARCHAR(20),
  BirthDate DATE,
  Gender VARCHAR(10),
  Address VARCHAR(50)
)

CREATE TABLE Appointments
(
  ApptID VARCHAR(10) PRIMARY KEY,
  DoctorID VARCHAR(10),
  PatientID VARCHAR(10),
  ApptDate DATE,
  ApptTime TIME,
  Status VARCHAR(20),
  FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
)

INSERT INTO Doctors
VALUES
  ('D001', 'Dr. Ahmed', 'Cardiology', 15, 1500.00, '01711-111111'),
  ('D002', 'Dr. Begum', 'Dermatology', 8, 1000.00, '01711-222222'),
  ('D003', 'Dr. Chowdhury', 'Neurology', 20, 2000.00, '01711-333333'),
  ('D004', 'Dr. Das', 'Orthopedics', 12, 1200.00, '01711-444444'),
  ('D005', 'Dr. Rahman', 'Cardiology', 10, 1400.00, '01711-555555'),
  ('D006', 'Dr. Sultana', 'Pediatrics', 6, 900.00, '01711-666666'),
  ('D007', 'Dr. Khan', 'General', 5, 500.00, '01711-777777'),
  ('D008', 'Dr. Islam', 'Dermatology', 14, 1100.00, '01711-888888');

INSERT INTO Patients
VALUES
  ('P001', 'Karim Hassan', '01811-111111', '1985-03-15', 'Male', 'Dhaka'),
  ('P002', 'Salma Khatun', '01811-222222', '1990-07-22', 'Female', 'Chittagong'),
  ('P003', 'Rahim Uddin', '01811-333333', '1978-11-30', 'Male', 'Sylhet'),
  ('P004', 'Nasrin Akter', '01811-444444', '1995-01-08', 'Female', 'Rajshahi'),
  ('P005', 'Jamal Hossain', '01811-555555', '1982-06-14', 'Male', 'Dhaka'),
  ('P006', 'Ruma Begum', '01811-666666', '2000-09-25', 'Female', 'Khulna'),
  ('P007', 'Kamal Mia', '01811-777777', '1975-12-03', 'Male', 'Barisal'),
  ('P008', 'Ayesha Siddika', '01811-888888', '1988-04-17', 'Female', 'Dhaka'),
  ('P009', 'Sohel Rana', '01811-999999', '1992-08-21', 'Male', 'Rangpur');

INSERT INTO Appointments
VALUES
  ('A001', 'D001', 'P001', '2024-04-01', '10:00', 'Completed'),
  ('A002', 'D002', 'P002', '2024-04-01', '11:00', 'Completed'),
  ('A003', 'D003', 'P003', '2024-04-02', '09:00', 'Completed'),
  ('A004', 'D001', 'P004', '2024-04-02', '14:00', 'Cancelled'),
  ('A005', 'D004', 'P005', '2024-04-03', '10:30', 'Completed'),
  ('A006', 'D005', 'P001', '2024-04-05', '15:00', 'Completed'),
  ('A007', 'D006', 'P006', '2024-04-08', '11:30', 'Scheduled'),
  ('A008', 'D007', 'P007', '2024-04-10', '09:30', 'Scheduled'),
  ('A009', 'D001', 'P008', '2024-04-10', '10:00', 'Scheduled'),
  ('A010', 'D002', 'P009', '2024-04-10', '14:00', 'Scheduled'),
  ('A011', 'D003', 'P002', '2024-04-12', '10:00', 'Scheduled'),
  ('A012', 'D004', 'P003', '2024-04-03', '15:30', 'Completed'),
  ('A013', 'D008', 'P004', '2024-04-15', '11:00', 'Scheduled'),
  ('A014', 'D005', 'P005', '2024-04-06', '09:00', 'Completed');

-- Question-1

-- 2. Write a SQL query to find all patients from Dhaka city.

-- 3. Write a SQL query to list doctors sorted by consultation fee in ascending order.

-- 4. Write a SQL query to count the total number of appointments scheduled for April 10, 2024.

-- 5. Write a SQL query to find patient names who have appointments with Dr. Ahmed (DoctorID = 'D001').

-- 6. Write a SQL query to display each doctor's name and the total number of appointments they have.

-- 7. Write a SQL query to find doctors who have more than 2 appointments scheduled.

-- 8. Write a SQL query to list patients who have never had any appointment.

-- 9. Write a SQL query to find the average consultation fee for each specialization.

-- 10. Write a SQL query to display patient name, doctor name, appointment date and time for all completed appointments.

-- 11. Write a SQL query to find the patient with the most number of appointments.

-- 12. Write a SQL query to list specializations that have more than one doctor.

-- 13. Write a SQL query to find doctors who have no scheduled appointments.

-- 14. Write a SQL query to display the count of appointments by status (Completed, Cancelled, Scheduled).

-- Question-1: Display the names and specializations of all doctors with more than 10 years of experience
SELECT d.Name, d.Specialization
FROM practice.Doctors d
WHERE d.Experience > 10;

-- Question-2: Find all patients from Dhaka city
SELECT p.PatientID, p.Name, p.Phone, p.BirthDate, p.Gender, p.Address
FROM practice.Patients p
WHERE p.Address = 'Dhaka';

-- Question-3: List doctors sorted by consultation fee in ascending order
SELECT d.DoctorID, d.Name, d.Specialization, d.Experience, d.ConsultationFee, d.Phone
FROM practice.Doctors d
ORDER BY d.ConsultationFee ASC;

-- Question-4: Count the total number of appointments scheduled for April 10, 2024
SELECT COUNT(*) AS AppointmentCount
FROM practice.Appointments a
WHERE a.ApptDate = '2024-04-10' AND a.Status = 'Scheduled';

-- Question-5: Find patient names who have appointments with Dr. Ahmed (DoctorID = 'D001')
SELECT p.Name
FROM practice.Patients p
JOIN practice.Appointments a ON p.PatientID = a.PatientID
WHERE a.DoctorID = 'D001';

-- Question-6: Display each doctor's name and the total number of appointments they have
SELECT d.Name, COUNT(a.ApptID) AS TotalAppointments
FROM practice.Doctors d
LEFT JOIN practice.Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.Name;

-- Question-7: Find doctors who have more than 2 appointments scheduled
SELECT d.DoctorID, d.Name, d.Specialization, COUNT(a.ApptID) AS ScheduledCount
FROM practice.Doctors d
JOIN practice.Appointments a ON d.DoctorID = a.DoctorID
WHERE a.Status = 'Scheduled'
GROUP BY d.DoctorID, d.Name, d.Specialization
HAVING COUNT(a.ApptID) > 2;

-- Question-8: List patients who have never had any appointment
SELECT p.PatientID, p.Name, p.Phone, p.BirthDate, p.Gender, p.Address
FROM practice.Patients p
WHERE p.PatientID NOT IN (
    SELECT DISTINCT a.PatientID
    FROM practice.Appointments a
);

-- Question-9: Find the average consultation fee for each specialization
SELECT d.Specialization, AVG(d.ConsultationFee) AS AverageFee
FROM practice.Doctors d
GROUP BY d.Specialization;

-- Question-10: Display patient name, doctor name, appointment date and time for all completed appointments
SELECT p.Name AS PatientName, d.Name AS DoctorName, a.ApptDate, a.ApptTime
FROM practice.Patients p
JOIN practice.Appointments a ON p.PatientID = a.PatientID
JOIN practice.Doctors d ON a.DoctorID = d.DoctorID
WHERE a.Status = 'Completed';

-- Question-11: Find the patient with the most number of appointments
SELECT TOP 1 p.PatientID, p.Name, COUNT(a.ApptID) AS AppointmentCount
FROM practice.Patients p
JOIN practice.Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.Name
ORDER BY COUNT(a.ApptID) DESC;

-- Question-12: List specializations that have more than one doctor
SELECT d.Specialization, COUNT(d.DoctorID) AS DoctorCount
FROM practice.Doctors d
GROUP BY d.Specialization
HAVING COUNT(d.DoctorID) > 1;

-- Question-13: Find doctors who have no scheduled appointments
SELECT d.DoctorID, d.Name, d.Specialization, d.Experience, d.ConsultationFee, d.Phone
FROM practice.Doctors d
WHERE d.DoctorID NOT IN (
    SELECT DISTINCT a.DoctorID
    FROM practice.Appointments a
    WHERE a.Status = 'Scheduled'
);

-- Question-14: Display the count of appointments by status
SELECT a.Status, COUNT(a.ApptID) AS AppointmentCount
FROM practice.Appointments a
GROUP BY a.Status;

-- Question-15: Find patients who have never consulted with a Cardiology specialist
SELECT p.PatientID, p.Name, p.Phone, p.BirthDate, p.Gender, p.Address
FROM practice.Patients p
WHERE p.PatientID NOT IN (
    SELECT DISTINCT a.PatientID
    FROM practice.Appointments a
    JOIN practice.Doctors d ON a.DoctorID = d.DoctorID
    WHERE d.Specialization = 'Cardiology'
);
