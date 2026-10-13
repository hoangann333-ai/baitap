-- Thuc hanh VIEW tren CSDL classicmodels
USE classicmodels;

-- 1. Tao view gom ma khach hang, ten khach hang va so dien thoai
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- 2. Truy van view vua tao
SELECT *
FROM customer_views;

-- 3. Cap nhat dinh nghia view: hien thi thong tin lien he
-- cua cac khach hang co dia chi tai Nantes
CREATE OR REPLACE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    contactFirstName,
    contactLastName,
    phone
FROM customers
WHERE city = 'Nantes';

-- Kiem tra view sau khi cap nhat
SELECT *
FROM customer_views;

-- 4. Xoa view khi khong con su dung.
-- Bo comment hai dong duoi va chay rieng neu muon xoa view.
-- DROP VIEW IF EXISTS customer_views;
