-- ============================================================
-- Medicine Shop Billing System
-- Database schema, starter categories and default admin account.
--
-- Import this file in phpMyAdmin, or run:
--   mysql -u root -p < medicine_shop.sql
--
-- Rename to GroupNo_Medicine.sql before final submission.
-- ============================================================

CREATE DATABASE IF NOT EXISTS `medicine_shop`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE `medicine_shop`;

-- ------------------------------------------------------------
-- Admins
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `admins` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `full_name` VARCHAR(100) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_admins_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- Categories
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `categories` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `description` VARCHAR(255) DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_categories_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- Products
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `products` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(150) NOT NULL,
    `generic_name` VARCHAR(150) DEFAULT NULL,
    `category_id` INT UNSIGNED NOT NULL,
    `unit` VARCHAR(50) NOT NULL DEFAULT 'Piece',
    `cost_price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `selling_price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `mrp` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `stock` INT UNSIGNED NOT NULL DEFAULT 0,
    `reorder_level` INT UNSIGNED NOT NULL DEFAULT 0,
    `expiry_date` DATE NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_products_category` (`category_id`),
    KEY `idx_products_name` (`name`),
    KEY `idx_products_expiry` (`expiry_date`),
    CONSTRAINT `fk_products_category`
        FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- Sales (one row per bill)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `sales` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `invoice_no` VARCHAR(30) NOT NULL,
    `customer_name` VARCHAR(100) DEFAULT NULL,
    `customer_phone` VARCHAR(20) DEFAULT NULL,
    `subtotal` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `discount` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `grand_total` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `payment_method` ENUM('Cash', 'Card', 'Mobile Banking') NOT NULL DEFAULT 'Cash',
    `total_cost` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    `sold_by` INT UNSIGNED DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_sales_invoice_no` (`invoice_no`),
    KEY `idx_sales_created_at` (`created_at`),
    KEY `idx_sales_sold_by` (`sold_by`),
    CONSTRAINT `fk_sales_admin`
        FOREIGN KEY (`sold_by`) REFERENCES `admins` (`id`)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- Sale items (cost price is copied so old profit reports stay fixed)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `sale_items` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `sale_id` INT UNSIGNED NOT NULL,
    `product_id` INT UNSIGNED DEFAULT NULL,
    `product_name` VARCHAR(150) NOT NULL,
    `quantity` INT UNSIGNED NOT NULL,
    `unit_price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `cost_price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `line_total` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`id`),
    KEY `idx_sale_items_sale` (`sale_id`),
    KEY `idx_sale_items_product` (`product_id`),
    CONSTRAINT `fk_sale_items_sale`
        FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `fk_sale_items_product`
        FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- Starter categories
-- ------------------------------------------------------------
INSERT INTO `categories` (`name`, `description`) VALUES
    ('Tablet', 'Oral tablet medicines'),
    ('Capsule', 'Oral capsule medicines'),
    ('Syrup', 'Liquid oral medicines'),
    ('Injection', 'Injectable medicines'),
    ('Ointment/Cream', 'Topical ointments and creams'),
    ('Drops', 'Eye, ear and nasal drops'),
    ('First Aid', 'Bandages, antiseptics and first aid supplies'),
    ('Baby Care', 'Baby food, diapers and baby care items'),
    ('Supplements', 'Vitamins, minerals and food supplements')
ON DUPLICATE KEY UPDATE `description` = VALUES(`description`);

-- ------------------------------------------------------------
-- Default admin account
-- Username: admin
-- Password: admin123  (change it after the first login)
-- ------------------------------------------------------------
INSERT INTO `admins` (`username`, `password`, `full_name`) VALUES
    ('admin', '$2y$12$me1OaS3jYExV7d9zJYwTRe/KC6OKIsL1YOV/lzUo.yBl6NnyrUmYi', 'Default Admin')
ON DUPLICATE KEY UPDATE `username` = VALUES(`username`);
