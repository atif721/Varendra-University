CREATE DATABASE IF NOT EXISTS myappdb;
USE myappdb;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Default test account: admin / 123456
INSERT INTO users (username, password) VALUES ('admin', MD5('123'));
