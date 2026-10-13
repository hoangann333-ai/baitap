-- Thuc hanh tham so IN, OUT, INOUT tren CSDL classicmodels
-- Hay nap database classicmodels truoc khi chay file nay.
USE classicmodels;

-- 1. IN: tim khach hang theo customerNumber
DROP PROCEDURE IF EXISTS getCusById;
DELIMITER //
CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END //
DELIMITER ;

CALL getCusById(175);

-- 2. OUT: tra so khach hang theo thanh pho qua bien session @total
DROP PROCEDURE IF EXISTS GetCustomersCountByCity;
DELIMITER //
CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //
DELIMITER ;

CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS total_customers_in_city;

-- 3. INOUT: nhan gia tri ban dau, cong them inc va tra ket qua vao cung bien
DROP PROCEDURE IF EXISTS SetCounter;
DELIMITER //
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //
DELIMITER ;

SET @counter = 1;

CALL SetCounter(@counter, 1);
SELECT @counter AS counter_after_call_1; -- 2

CALL SetCounter(@counter, 1);
SELECT @counter AS counter_after_call_2; -- 3

CALL SetCounter(@counter, 5);
SELECT @counter AS counter_after_call_3; -- 8
