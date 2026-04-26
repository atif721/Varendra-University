-- =====================================================
-- PRACTICE SET 01
-- Database Management System Lab
-- Mid Term Practice Questions
-- =====================================================

-- SCENARIO: LIBRARY MANAGEMENT SYSTEM

-- TABLE: Books
-- +------------+------------------------+------------+--------+----------+
-- | BookID     | Title                  | Author     | Year | Price    |
-- +------------+------------------------+------------+--------+----------+
-- | B001       | Database Systems       | Ramakrishnan | 2020 | 850.00  |
-- | B002       | Operating Systems      | Silberschatz | 2019 | 720.00  |
-- | B003       | Data Structures        | Cormen     | 2021 | 650.00  |
-- | B004       | Algorithms             | Cormen     | 2021 | 700.00  |
-- | B005       | Computer Networks      | Kurose     | 2018 | 580.00  |
-- | B006       | Database Systems       | Elmasri    | 2020 | 800.00  |
-- | B007       | Web Development        | Pressman   | 2019 | 450.00  |
-- | B008       | Software Engineering   | Pressman   | 2020 | 520.00  |
-- | B009       | Artificial Intelligence| Russell    | 2021 | 900.00  |
-- | B010       | Machine Learning       | Mitchell   | 2022 | 750.00  |
-- +------------+------------------------+------------+--------+----------+

-- TABLE: Members
-- +------------+----------------+---------------+------------+--------------+
-- | MemberID   | Name           | Email         | JoinDate   | MembershipType|
-- +------------+----------------+---------------+------------+--------------+
-- | M001       | Alice Johnson  | alice@mail.com| 2023-01-15 | Premium      |
-- | M002       | Bob Smith      | bob@mail.com  | 2023-02-20 | Regular      |
-- | M003       | Carol White    | carol@mail.com| 2023-03-10 | Premium      |
-- | M004       | David Brown    | david@mail.com| 2023-04-05 | Regular      |
-- | M005       | Emma Davis     | emma@mail.com | 2023-05-12 | Premium      |
-- | M006       | Frank Miller   | frank@mail.com| 2023-06-18 | Regular      |
-- | M007       | Grace Wilson   | grace@mail.com| 2023-07-22 | Premium      |
-- | M008       | Henry Taylor   | henry@mail.com| 2023-08-30 | Regular      |
-- +------------+----------------+---------------+------------+--------------+

-- TABLE: BorrowRecords
-- +------------+------------+------------+-------------+------------+----------+
-- | RecordID   | BookID     | MemberID   | IssueDate   | ReturnDate | Status   |
-- +------------+------------+------------+-------------+------------+----------+
-- | R001       | B001       | M001       | 2024-01-10  | 2024-01-24 | Returned |
-- | R002       | B003       | M002       | 2024-01-15  | 2024-01-29 | Returned |
-- | R003       | B005       | M003       | 2024-02-01  | NULL       | Borrowed |
-- | R004       | B002       | M001       | 2024-02-10  | 2024-02-24 | Returned |
-- | R005       | B007       | M004       | 2024-02-15  | NULL       | Borrowed |
-- | R006       | B001       | M005       | 2024-03-01  | 2024-03-15 | Returned |
-- | R007       | B009       | M003       | 2024-03-05  | NULL       | Borrowed |
-- | R008       | B004       | M006       | 2024-03-10  | 2024-03-24 | Returned |
-- | R009       | B006       | M007       | 2024-03-15  | NULL       | Borrowed |
-- | R010       | B008       | M002       | 2024-03-20  | 2024-04-03 | Returned |
-- | R011       | B010       | M008       | 2024-04-01  | NULL       | Borrowed |
-- | R012       | B003       | M005       | 2024-04-05  | NULL       | Borrowed |
-- +------------+------------+------------+-------------+------------+----------+

-- =====================================================
-- QUESTIONS (1-15)
-- =====================================================

-- 1. Write a SQL query to display all book titles written by author 'Cormen'.

-- 2. Write a SQL query to find the names and emails of all Premium members.

-- 3. Write a SQL query to list all books with price greater than 700, sorted by price in descending order.

-- 4. Write a SQL query to count the total number of books currently borrowed (Status = 'Borrowed').

-- 5. Write a SQL query to find the member names who have borrowed the book with BookID 'B001'.

-- 6. Write a SQL query to display the book title and the number of times each book has been borrowed.

-- 7. Write a SQL query to find members who have borrowed more than 1 book.

-- 8. Write a SQL query to list all books that have never been borrowed.

-- 9. Write a SQL query to find the total revenue (sum of prices) of all books by each author.

-- 10. Write a SQL query to display member name, book title, and issue date for all currently borrowed books.

-- 11. Write a SQL query to find the member who has borrowed the most number of books.

-- 12. Write a SQL query to list authors who have written more than one book in the library.

-- 13. Write a SQL query to find books that are currently available (not borrowed).

-- 14. Write a SQL query to display the average price of books grouped by publication year.

-- 15. Write a SQL query to find members who have never borrowed any book written by 'Cormen'.


USE Final
Go

-- CREATE TABLE Books
-- (
--   BookID VARCHAR(10) PRIMARY KEY,
--   Title VARCHAR(50),
--   Author VARCHAR(50),
--   Year DATE,
--   Price INT
-- )

-- CREATE TABLE Members
-- (
--   MemberID VARCHAR(10) PRIMARY KEY,
--   Name VARCHAR(50),
--   Email VARCHAR(50),
--   JoinDate DATE,
--   MembershipType VARCHAR(10)
-- )

-- CREATE TABLE BorrowRecords
-- (
--   RecordID VARCHAR(10) PRIMARY KEY,
--   BookID VARCHAR(10),
--   MemberID VARCHAR(10),
--   IssueDate DATE,
--   ReturnDate DATE,
--   Status VARCHAR(20),
--   FOREIGN KEY (BookID) REFERENCES  Books(BookID),
--   FOREIGN KEY (MemberID) REFERENCES  Members(MemberID)
-- )

-- INSERT INTO Books
-- VALUES
--   ('B001', 'Database Systems', 'Ramakrishnan', '2020', 850.00),
--   ('B002', 'Operating Systems', 'Silberschatz', '2019', 720.00),
--   ('B003', 'Data Structures', 'Cormen', '2021', 650.00),
--   ('B004', 'Algorithms', 'Cormen', '2021', 700.00),
--   ('B005', 'Computer Networks', 'Kurose', '2018', 580.00),
--   ('B006', 'Database Systems', 'Elmasri', '2020', 800.00),
--   ('B007', 'Web Development', 'Pressman', '2019', 450.00),
--   ('B008', 'Software Engineering', 'Pressman', '2020', 520.00),
--   ('B009', 'Artificial Intelligence', 'Russell', '2021', 900.00),
--   ('B010', 'Machine Learning', 'Mitchell', '2022', 750.00);

-- INSERT INTO Members
-- VALUES
--   ('M001', 'Alice Johnson', 'alice@mail.com', '2023-01-15', 'Premium'),
--   ('M002', 'Bob Smith', 'bob@mail.com', '2023-02-20', 'Regular'),
--   ('M003', 'Carol White', 'carol@mail.com', '2023-03-10', 'Premium'),
--   ('M004', 'David Brown', 'david@mail.com', '2023-04-05', 'Regular'),
--   ('M005', 'Emma Davis', 'emma@mail.com', '2023-05-12', 'Premium'),
--   ('M006', 'Frank Miller', 'frank@mail.com', '2023-06-18', 'Regular'),
--   ('M007', 'Grace Wilson', 'grace@mail.com', '2023-07-22', 'Premium'),
--   ('M008', 'Henry Taylor', 'henry@mail.com', '2023-08-30', 'Regular');

-- INSERT INTO BorrowRecords
-- VALUES
--   ('R001', 'B001', 'M001', '2024-01-10', '2024-01-24', 'Returned'),
--   ('R002', 'B003', 'M002', '2024-01-15', '2024-01-29', 'Returned'),
--   ('R003', 'B005', 'M003', '2024-02-01', NULL, 'Borrowed'),
--   ('R004', 'B002', 'M001', '2024-02-10', '2024-02-24', 'Returned'),
--   ('R005', 'B007', 'M004', '2024-02-15', NULL, 'Borrowed'),
--   ('R006', 'B001', 'M005', '2024-03-01', '2024-03-15', 'Returned'),
--   ('R007', 'B009', 'M003', '2024-03-05', NULL, 'Borrowed'),
--   ('R008', 'B004', 'M006', '2024-03-10', '2024-03-24', 'Returned'),
--   ('R009', 'B006', 'M007', '2024-03-15', NULL, 'Borrowed'),
--   ('R010', 'B008', 'M002', '2024-03-20', '2024-04-03', 'Returned'),
--   ('R011', 'B010', 'M008', '2024-04-01', NULL, 'Borrowed'),
--   ('R012', 'B003', 'M005', '2024-04-05', NULL, 'Borrowed');

-- SELECT *
-- FROM Books;

-- SELECT *
-- FROM Members;

-- SELECT *
-- FROM BorrowRecords

-- Question-1: Display all book titles written by author 'Cormen'
SELECT b.Title
FROM practice.Books b
WHERE b.Author = 'Cormen';

-- Question-2: Find the names and emails of all Premium members
SELECT mb.Name, mb.Email
FROM practice.Members mb
WHERE mb.MembershipType = 'Premium';

-- Question-3: List all books with price greater than 700, sorted by price in descending order
SELECT b.BookID, b.Title, b.Author, b.Year, b.Price
FROM practice.Books b
WHERE b.Price > 700
ORDER BY b.Price DESC;

-- Question-4: Count the total number of books currently borrowed (Status = 'Borrowed')
SELECT COUNT(*) AS BorrowedBooksCount
FROM practice.BorrowRecords br
WHERE br.Status = 'Borrowed';

-- Question-5: Find the member names who have borrowed the book with BookID 'B001'
SELECT mb.Name
FROM practice.Members mb
JOIN practice.BorrowRecords br ON mb.MemberID = br.MemberID
WHERE br.BookID = 'B001';

-- Question-6: Display the book title and the number of times each book has been borrowed
SELECT b.Title, COUNT(br.RecordID) AS BorrowCount
FROM practice.Books b
LEFT JOIN practice.BorrowRecords br ON b.BookID = br.BookID
GROUP BY b.BookID, b.Title;

-- Question-7: Find members who have borrowed more than 1 book
SELECT mb.MemberID, mb.Name, COUNT(br.RecordID) AS BorrowCount
FROM practice.Members mb
JOIN practice.BorrowRecords br ON mb.MemberID = br.MemberID
GROUP BY mb.MemberID, mb.Name
HAVING COUNT(br.RecordID) > 1;

-- Question-8: List all books that have never been borrowed
SELECT b.BookID, b.Title, b.Author, b.Year, b.Price
FROM practice.Books b
LEFT JOIN practice.BorrowRecords br ON b.BookID = br.BookID
WHERE br.RecordID IS NULL;

-- Question-9: Find the total revenue (sum of prices) of all books by each author
SELECT b.Author, SUM(b.Price) AS TotalRevenue
FROM practice.Books b
GROUP BY b.Author;

-- Question-10: Display member name, book title, and issue date for all currently borrowed books
SELECT mb.Name AS MemberName, b.Title AS BookTitle, br.IssueDate
FROM practice.Members mb
JOIN practice.BorrowRecords br ON mb.MemberID = br.MemberID
JOIN practice.Books b ON br.BookID = b.BookID
WHERE br.Status = 'Borrowed';

-- Question-11: Find the member who has borrowed the most number of books
SELECT TOP 1 mb.MemberID, mb.Name, COUNT(br.RecordID) AS BorrowCount
FROM practice.Members mb
JOIN practice.BorrowRecords br ON mb.MemberID = br.MemberID
GROUP BY mb.MemberID, mb.Name
ORDER BY COUNT(br.RecordID) DESC;

-- Question-12: List authors who have written more than one book in the library
SELECT b.Author, COUNT(b.BookID) AS BookCount
FROM practice.Books b
GROUP BY b.Author
HAVING COUNT(b.BookID) > 1;

-- Question-13: Find books that are currently available (not borrowed)
SELECT b.BookID, b.Title, b.Author, b.Year, b.Price
FROM practice.Books b
WHERE b.BookID NOT IN (
    SELECT br.BookID
    FROM practice.BorrowRecords br
    WHERE br.Status = 'Borrowed'
);

-- Question-14: Display the average price of books grouped by publication year
SELECT b.Year, AVG(b.Price) AS AveragePrice
FROM practice.Books b
GROUP BY b.Year;

-- Question-15: Find members who have never borrowed any book written by 'Cormen'
SELECT mb.MemberID, mb.Name, mb.Email
FROM practice.Members mb
WHERE mb.MemberID NOT IN (
    SELECT DISTINCT br.MemberID
    FROM practice.BorrowRecords br
    JOIN practice.Books b ON br.BookID = b.BookID
    WHERE b.Author = 'Cormen'
);
