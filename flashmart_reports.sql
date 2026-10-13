-- FlashMart: tao du lieu mau va chay hai bao cao JOIN
-- MySQL 8.0+
-- Chay mot lan tren CSDL mau moi.

CREATE DATABASE IF NOT EXISTS flashmart_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE flashmart_db;

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (customer_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Products (
    product_id INT NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (product_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (order_id),
    KEY idx_orders_customer_id (customer_id),
    KEY idx_orders_product_id (product_id),
    CONSTRAINT fk_orders_customers
      FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_orders_products
      FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE=InnoDB;

-- Du lieu mau theo de bai
INSERT INTO Customers (customer_id, name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie');

INSERT INTO Products (product_id, product_name)
VALUES
    (101, 'Laptop'),
    (102, 'Mouse'),
    (103, 'Keyboard');

INSERT INTO Orders (order_id, customer_id, product_id)
VALUES
    (1001, 1, 101),
    (1002, 1, 102),
    (1003, 2, 101);

-- Bao cao Marketing: giu tat ca khach hang, ke ca nguoi chua mua.
-- COUNT(o.order_id) dem 0 cho Charlie; COUNT(*) se dem thanh 1 do dong LEFT JOIN.
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;

-- Bao cao Kho van: anti-join tim san pham chua tung duoc ban.
SELECT
    p.product_id,
    p.product_name
FROM Products AS p
LEFT JOIN Orders AS o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL
ORDER BY p.product_id;
