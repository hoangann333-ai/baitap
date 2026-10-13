USE classicmodels;

-- Tạo thủ tục hiển thị toàn bộ khách hàng
DROP PROCEDURE IF EXISTS findAllCustomers;

DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers;
END //

DELIMITER ;

-- Gọi thủ tục
CALL findAllCustomers();

-- Tạo lại thủ tục để tìm khách hàng có mã 175
DROP PROCEDURE IF EXISTS findAllCustomers;

DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = 175;
END //

DELIMITER ;

-- Gọi lại thủ tục
CALL findAllCustomers();
