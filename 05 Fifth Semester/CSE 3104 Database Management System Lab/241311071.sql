CREATE TABLE workers
(
    WORKER_ID INT PRIMARY KEY NOT NULL,
    FIRST_NAME VARCHAR(30) UNIQUE,
    LAST_NAME VARCHAR(30),
    SALARY INT,
    DEPT_NAME VARCHAR(10),
    JOINING_DATE DATETIME,
    CHECK (SALARY > 100)
);

INSERT INTO
    workers
    (
    WORKER_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    DEPT_NAME,
    JOINING_DATE
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

-- 1. Display all the information of worker table.
SELECT
    *
FROM
    workers;

-- 2. Display all the information of 1st 5 workers of worker table.
SELECT
    *
FROM
    workers
LIMIT
5;

-- 3. Display fullname of all workers.
SELECT
    CONCAT (FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME
FROM
    workers;

-- 4. Complete record of worker who works in admin
SELECT
    *
FROM
    workers
WHERE
    DEPT_NAME = 'Admin';

-- 5. Name of those whose salary is greater than 10000
SELECT
    CONCAT (FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME
FROM
    workers
WHERE
    SALARY > 10000;

-- 6. All who have more salary than sanjoy
SELECT
    *
FROM
    workers
WHERE
    SALARY > (
        SELECT
    SALARY
FROM
    workers
WHERE
            FIRST_NAME = 'Sanjoy'
    );

-- 7. update salary of worker by 95000 whose id is 8 
UPDATE workers
SET
    SALARY = SALARY + 95000
WHERE
    WORKER_ID = 8;

-- 8. Delete record whose first name is Asad
DELETE FROM workers
WHERE
    FIRST_NAME = 'Asad';