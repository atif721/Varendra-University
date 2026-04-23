-- =====================================================
-- PRACTICE SET 03
-- Database Management System Lab
-- Mid Term Practice Questions
-- =====================================================

-- SCENARIO: E-COMMERCE ORDER MANAGEMENT SYSTEM

-- TABLE: Customers
-- +------------+----------------+---------------+------------+--------------+
-- | CustomerID | Name           | Email         | City       | JoinDate     |
-- +------------+----------------+---------------+------------+--------------+
-- | C001       | Shahidul Islam | shahid@mail.com| Dhaka     | 2023-01-10   |
-- | C002       | Mahmuda Khatun | mahmuda@mail.com| Chittagong| 2023-02-15 |
-- | C003       | Rafiqul Hassan | rafiq@mail.com | Sylhet    | 2023-03-20   |
-- | C004       | Taslima Begum  | taslima@mail.com| Dhaka    | 2023-04-05   |
-- | C005       | Kamrul Hasan   | kamrul@mail.com| Rajshahi  | 2023-05-12   |
-- | C006       | Farhana Akter  | farhana@mail.com| Khulna   | 2023-06-18   |
-- | C007       | Mizanur Rahman | mizan@mail.com | Dhaka     | 2023-07-22   |
-- | C008       | Shahana Parvin | shahana@mail.com| Barisal  | 2023-08-30   |
-- +------------+----------------+---------------+------------+--------------+

-- TABLE: Products
-- +------------+------------------------+---------------+--------+----------+-----------+
-- | ProductID  | ProductName           | Category      | Stock  | Price    | Supplier  |
-- +------------+------------------------+---------------+--------+----------+-----------+
-- | P001       | Wireless Mouse        | Electronics   | 150    | 450.00   | TechCorp  |
-- | P002       | Mechanical Keyboard   | Electronics   | 75     | 1200.00  | TechCorp  |
-- | P003       | USB Hub 4-Port        | Electronics   | 200    | 350.00   | GadgetInc |
-- | P004       | Laptop Stand          | Accessories   | 100    | 800.00   | OfficePro |
-- | P005       | Webcam HD 1080p       | Electronics   | 60     | 1500.00  | TechCorp  |
-- | P006       | Desk Organizer        | Accessories   | 250    | 400.00   | OfficePro |
-- | P007       | Bluetooth Speaker     | Electronics   | 90     | 950.00   | GadgetInc |
-- | P008       | Monitor Arm           | Accessories   | 45     | 1800.00  | OfficePro |
-- | P009       | Headphones Wireless   | Electronics   | 120    | 2200.00  | TechCorp  |
-- | P010       | Cable Management Kit  | Accessories   | 300    | 250.00   | OfficePro |
-- +------------+------------------------+---------------+--------+----------+-----------+

-- TABLE: Orders
-- +------------+------------+-------------+------------+----------+---------------+
-- | OrderID    | CustomerID | ProductID   | OrderDate  | Quantity | OrderStatus   |
-- +------------+------------+-------------+------------+----------+---------------+
-- | O001       | C001       | P001        | 2024-03-01 | 2        | Delivered     |
-- | O002       | C002       | P002        | 2024-03-02 | 1        | Delivered     |
-- | O003       | C003       | P003        | 2024-03-05 | 3        | Delivered     |
-- | O004       | C001       | P004        | 2024-03-10 | 1        | Delivered     |
-- | O005       | C004       | P005        | 2024-03-12 | 2        | Shipped       |
-- | O006       | C005       | P001        | 2024-03-15 | 1        | Delivered     |
-- | O007       | C002       | P007        | 2024-03-18 | 1        | Processing    |
-- | O008       | C006       | P008        | 2024-03-20 | 1        | Shipped       |
-- | O009       | C003       | P009        | 2024-03-22 | 1        | Delivered     |
-- | O010       | C007       | P002        | 2024-03-25 | 1        | Processing    |
-- | O011       | C001       | P006        | 2024-03-28 | 2        | Delivered     |
-- | O012       | C008       | P010        | 2024-04-01 | 4        | Shipped       |
-- | O013       | C004       | P001        | 2024-04-05 | 1        | Processing    |
-- | O014       | C005       | P007        | 2024-04-08 | 2        | Pending       |
-- | O015       | C002       | P009        | 2024-04-10 | 1        | Pending       |
-- +------------+------------+-------------+------------+----------+---------------+

-- =====================================================
-- QUESTIONS (1-15)
-- =====================================================

-- 1. Write a SQL query to display all product names from the 'Electronics' category.

-- 2. Write a SQL query to find all customers from Dhaka city.

-- 3. Write a SQL query to list products sorted by price in descending order (highest first).

-- 4. Write a SQL query to count the total number of orders with status 'Delivered'.

-- 5. Write a SQL query to find customer names who have ordered product 'P001'.

-- 6. Write a SQL query to display each product name and the total quantity sold.

-- 7. Write a SQL query to find customers who have placed more than 1 order.

-- 8. Write a SQL query to list products that have never been ordered.

-- 9. Write a SQL query to find the total revenue (price × quantity) for each category.

-- 10. Write a SQL query to display customer name, product name, quantity, and order date for all orders.

-- 11. Write a SQL query to find the customer who has placed the most number of orders.

-- 12. Write a SQL query to list suppliers who supply more than one product.

-- 13. Write a SQL query to find products with stock less than 100 units.

-- 14. Write a SQL query to display the count of orders by order status.

-- 15. Write a SQL query to find customers who have never ordered any product from the 'Accessories' category.
