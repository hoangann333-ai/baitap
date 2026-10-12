-- AutoRide: nâng cấp CSDL từ cấu trúc legacy
-- MySQL 8.0.16+ (để thực thi các CHECK constraint)
-- Chạy một lần trên CSDL mới/legacy có bảng Cars và Rentals theo đề.

CREATE DATABASE IF NOT EXISTS autoride_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE autoride_db;

-- Hai bảng legacy tối thiểu. Nếu đã có sẵn từ hệ thống cũ,
-- CREATE TABLE IF NOT EXISTS sẽ giữ nguyên dữ liệu hiện tại.
CREATE TABLE IF NOT EXISTS Cars (
    car_id INT NOT NULL AUTO_INCREMENT,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) NOT NULL,
    PRIMARY KEY (car_id),
    UNIQUE KEY uq_cars_license_plate (license_plate)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT NOT NULL AUTO_INCREMENT,
    car_id INT,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'BOOKED',
    PRIMARY KEY (rental_id),
    CONSTRAINT fk_rentals_cars
      FOREIGN KEY (car_id) REFERENCES Cars(car_id)
) ENGINE=InnoDB;

-- Nâng cấp Rentals: khóa chặt vòng đời và bổ sung dữ liệu tiền.
ALTER TABLE Rentals
  MODIFY COLUMN status
    ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED')
    NOT NULL DEFAULT 'BOOKED',
  ADD COLUMN scheduled_return_date DATETIME NULL
    COMMENT 'Thời điểm dự kiến trả xe, dùng đối chiếu trả trễ',
  ADD COLUMN security_deposit DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  ADD COLUMN late_fee DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  ADD COLUMN damage_fee DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  ADD CONSTRAINT chk_rentals_deposit_nonnegative CHECK (security_deposit >= 0),
  ADD CONSTRAINT chk_rentals_late_fee_nonnegative CHECK (late_fee >= 0),
  ADD CONSTRAINT chk_rentals_damage_fee_nonnegative CHECK (damage_fee >= 0);

-- Một hợp đồng có thể có nhiều lần kiểm tra (nhận xe, trả xe, tái kiểm tra).
-- Vì vậy Rentals 1-N Inspections; mỗi inspection thuộc đúng một rental.
CREATE TABLE IF NOT EXISTS Inspections (
    inspection_id INT NOT NULL AUTO_INCREMENT,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT NULL,
    inspector_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (inspection_id),
    KEY idx_inspections_rental_id (rental_id),
    CONSTRAINT fk_inspections_rentals
      FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Kịch bản: khách thuê, nhận xe, trả đúng hạn nhưng làm vỡ đèn pha.
INSERT INTO Cars (model_name, license_plate)
VALUES ('Toyota Vios', 'AUTORIDE-001');

SET @car_id = LAST_INSERT_ID();

INSERT INTO Rentals (
    car_id, customer_name, rent_date, scheduled_return_date,
    return_date, status, security_deposit, late_fee, damage_fee
)
VALUES (
    @car_id, 'Nguyen Van A', '2026-10-12 09:00:00',
    '2026-10-14 09:00:00', NULL, 'BOOKED', 10000000.00, 0.00, 0.00
);

SET @rental_id = LAST_INSERT_ID();

-- Khách nhận xe: BOOKED -> ACTIVE.
UPDATE Rentals
SET status = 'ACTIVE'
WHERE rental_id = @rental_id;

-- Khách trả xe đúng hạn; ghi biên bản hư hỏng.
INSERT INTO Inspections (
    rental_id, inspection_date, damage_description, inspector_name
)
VALUES (
    @rental_id, '2026-10-14 09:00:00',
    'Vỡ đèn pha trái', 'Nhan vien kiem tra'
);

-- Hoàn tất hợp đồng và ghi nhận các khoản phí.
UPDATE Rentals
SET status = 'COMPLETED',
    return_date = '2026-10-14 09:00:00',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = @rental_id;

-- Tiền hoàn lại = tiền cọc - phí trễ - phí hư hỏng.
SELECT
    r.rental_id,
    r.customer_name,
    r.status,
    r.security_deposit,
    r.late_fee,
    r.damage_fee,
    (r.security_deposit - r.late_fee - r.damage_fee) AS refund_amount,
    i.damage_description,
    i.inspector_name
FROM Rentals AS r
LEFT JOIN Inspections AS i ON i.rental_id = r.rental_id
WHERE r.rental_id = @rental_id;
