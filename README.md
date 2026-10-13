USE classicmodels;

-- 1. Xem kế hoạch trước khi tạo index
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- 2. Tạo index cho customerName
ALTER TABLE customers
ADD INDEX idx_customerName (customerName);

-- 3. Xem kế hoạch sau khi tạo index
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- 4. Tạo index kết hợp cho tên liên hệ
ALTER TABLE customers
ADD INDEX idx_full_name (contactFirstName, contactLastName);

-- 5. Kiểm tra kế hoạch với index kết hợp
EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
   OR contactFirstName = 'King';
   EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
  AND contactLastName = 'King';
