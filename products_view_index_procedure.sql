-- Bai thuc hanh: View, Index, Stored Procedure tren MySQL
-- Chay mot lan tren CSDL demo moi.

CREATE DATABASE IF NOT EXISTS demo_products
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE demo_products;

CREATE TABLE IF NOT EXISTS Products (
    Id INT NOT NULL AUTO_INCREMENT,
    productCode VARCHAR(20) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10, 2) NOT NULL,
    productAmount INT NOT NULL DEFAULT 0,
    productDescription TEXT,
    productStatus BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (Id)
) ENGINE=InnoDB;

-- Du lieu mau
INSERT INTO Products
    (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
    ('PRD001', 'Laptop', 1200.00, 15, 'Laptop van phong', TRUE),
    ('PRD002', 'Mouse', 25.50, 80, 'Chuot khong day', TRUE),
    ('PRD003', 'Keyboard', 75.00, 40, 'Ban phim co', TRUE),
    ('PRD004', 'Monitor', 320.00, 22, 'Man hinh 27 inch', TRUE),
    ('PRD005', 'Headphone', 95.00, 35, 'Tai nghe chong on', TRUE),
    ('PRD006', 'Webcam', 60.00, 18, 'Webcam HD', TRUE),
    ('PRD007', 'Laptop', 1800.00, 8, 'Laptop do hoa', TRUE),
    ('PRD008', 'USB Hub', 35.00, 50, 'Hub USB-C', TRUE),
    ('PRD009', 'Speaker', 110.00, 12, 'Loa may tinh', FALSE),
    ('PRD010', 'Mouse Pad', 12.00, 100, 'Lot chuot', TRUE);

-- A. EXPLAIN truoc khi tao index
EXPLAIN
SELECT Id, productName, productPrice
FROM Products
WHERE productName = 'Laptop'
  AND productPrice = 1200.00;

-- B. Tao Unique Index va Composite Index
CREATE UNIQUE INDEX idx_products_productCode
    ON Products (productCode);

CREATE INDEX idx_products_name_price
    ON Products (productName, productPrice);

ANALYZE TABLE Products;

-- C. EXPLAIN lai cung truy van sau khi tao index
EXPLAIN
SELECT Id, productName, productPrice
FROM Products
WHERE productName = 'Laptop'
  AND productPrice = 1200.00;

-- Kiem tra index da ton tai
SHOW INDEX FROM Products;

-- Luu y: bang mau nho nen optimizer co the van chon type=ALL
-- vi quet it dong re hon doc index. Tren du lieu lon, hay so sanh lai.

-- D. Tao view lay thong tin san pham
CREATE OR REPLACE VIEW product_views AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

SELECT * FROM product_views;

-- E. Sua view: chi hien thi san pham dang kinh doanh
CREATE OR REPLACE VIEW product_views AS
SELECT productCode, productName, productPrice, productStatus
FROM Products
WHERE productStatus = TRUE;

SELECT * FROM product_views;

-- F. Xoa view theo yeu cau bai tap
DROP VIEW IF EXISTS product_views;

-- G. Stored procedure lay tat ca san pham
DROP PROCEDURE IF EXISTS sp_get_all_products;
DELIMITER //
CREATE PROCEDURE sp_get_all_products()
BEGIN
    SELECT *
    FROM Products
    ORDER BY Id;
END //
DELIMITER ;

-- H. Stored procedure them san pham
DROP PROCEDURE IF EXISTS sp_add_product;
DELIMITER //
CREATE PROCEDURE sp_add_product(
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(10, 2),
    IN p_productAmount INT,
    IN p_productDescription TEXT,
    IN p_productStatus BOOLEAN
)
BEGIN
    INSERT INTO Products
        (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES
        (p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription, p_productStatus);
END //
DELIMITER ;

-- I. Stored procedure cap nhat thong tin san pham theo Id
DROP PROCEDURE IF EXISTS sp_update_product;
DELIMITER //
CREATE PROCEDURE sp_update_product(
    IN p_Id INT,
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(10, 2),
    IN p_productAmount INT,
    IN p_productDescription TEXT,
    IN p_productStatus BOOLEAN
)
BEGIN
    UPDATE Products
    SET productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_Id;
END //
DELIMITER ;

-- J. Stored procedure xoa san pham theo Id
DROP PROCEDURE IF EXISTS sp_delete_product;
DELIMITER //
CREATE PROCEDURE sp_delete_product(IN p_Id INT)
BEGIN
    DELETE FROM Products
    WHERE Id = p_Id;
END //
DELIMITER ;

-- K. Goi thu cac procedure tren mot san pham demo roi xoa san pham do
CALL sp_get_all_products();

CALL sp_add_product(
    'PRD-DEMO', 'Demo Product', 10.00, 1, 'San pham thu procedure', TRUE
);
SET @new_product_id = LAST_INSERT_ID();

CALL sp_update_product(
    @new_product_id, 'PRD-DEMO', 'Demo Product Updated',
    12.50, 2, 'Da cap nhat bang procedure', TRUE
);

CALL sp_get_all_products();

CALL sp_delete_product(@new_product_id);

-- Xac nhan san pham demo da duoc xoa (ket qua rong)
SELECT *
FROM Products
WHERE productCode = 'PRD-DEMO';
