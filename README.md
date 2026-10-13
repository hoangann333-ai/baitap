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
DROP PROCEDURE IF EXISTS findAllCustomers;

DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = 175;
END //

DELIMITER ;

-- Gọi lại thủ tục sau khi thay đổi
CALL findAllCustomers();
