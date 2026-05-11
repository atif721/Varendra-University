CREATE DATABASE RDBMS_DB;
USE RDBMS_DB;

CREATE TABLE Customer(
    customer_ID INT NOT NULL,
    Names VARCHAR(30),
    age INT,
    city VARCHAR(30),
    PRIMARY KEY(customer_ID)
)

INSERT INTO Customer (customer_ID, Names, age,city)  VALUES
    (9,'Sabbir',22,'Natore'),
    (3,'Daniel',21,'Natore');

SELECT * FROM Customer

CREATE NONCLUSTERED INDEX customer_index ON Customer(Names)
SELECT * FROM Customer WHERE Names = 'Sabbir'


CREATE TABLE Orders(
    Order_ID INT NOT NULL,
    customer_ID INT,
    product_ID INT,
    Times DATETIME,
    PRIMARY KEY(Order_ID),
    FOREIGN KEY(customer_ID) REFERENCES Customer(customer_ID)
)

CREATE TABLE Products(
    Product_ID INT,
    order_ID INT,
    Qauntity INT,
    Price INT,
    Times DATETIME,
    FOREIGN KEY(order_ID) REFERENCES Orders(Order_ID)
)

CREATE UNIQUE NONCLUSTERED INDEX Product_ID ON Products(Qauntity)
