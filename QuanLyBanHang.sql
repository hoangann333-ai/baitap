-- CSDL QuanLyBanHang
-- MySQL 8.0+
-- Mô hình: Customer 1-N Order; Order N-M Product thông qua OrderDetail.

CREATE DATABASE IF NOT EXISTS QuanLyBanHang
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE QuanLyBanHang;

CREATE TABLE IF NOT EXISTS Customer (
    cID INT NOT NULL AUTO_INCREMENT,
    cName VARCHAR(100) NOT NULL,
    cAge TINYINT UNSIGNED NULL,
    PRIMARY KEY (cID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Product (
    pID INT NOT NULL AUTO_INCREMENT,
    pName VARCHAR(100) NOT NULL,
    pPrice DECIMAL(12, 2) NOT NULL,
    PRIMARY KEY (pID),
    CONSTRAINT chk_product_price_nonnegative CHECK (pPrice >= 0)
) ENGINE=InnoDB;

-- Order là từ có thể gây xung đột với từ khóa SQL; dùng backtick khi tham chiếu.
CREATE TABLE IF NOT EXISTS `Order` (
    oID INT NOT NULL AUTO_INCREMENT,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (oID),
    CONSTRAINT fk_order_customer
        FOREIGN KEY (cID) REFERENCES Customer(cID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_order_total_nonnegative CHECK (oTotalPrice >= 0)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL,
    PRIMARY KEY (oID, pID),
    CONSTRAINT fk_orderdetail_order
        FOREIGN KEY (oID) REFERENCES `Order`(oID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_orderdetail_product
        FOREIGN KEY (pID) REFERENCES Product(pID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_orderdetail_quantity_positive CHECK (odQTY > 0)
) ENGINE=InnoDB;

-- Kiểm tra các bảng đã tạo:
SHOW TABLES;

-- Quan hệ:
-- Customer (1) -> (N) Order
-- Order (1) -> (N) OrderDetail
-- Product (1) -> (N) OrderDetail
