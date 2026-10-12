-- HealthSync: migration va mo phong quy trinh dat lich, kham benh
-- Dieu kien: da chay Legacy SQL Script, cac bang Patients, Doctors,
-- Appointments ton tai trong healthsync_db.
-- Chay file nay mot lan tren MySQL 8.0.16+ (CHECK duoc enforce tu 8.0.16).

USE healthsync_db;

-- 1. Them cac cot phuc vu lifecycle va doi soat tien coc.
ALTER TABLE Appointments
    ADD COLUMN status ENUM(
        'PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED'
    ) NULL AFTER appointment_date,
    ADD COLUMN deposit_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ADD COLUMN penalty_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ADD COLUMN cancel_reason VARCHAR(255) NULL;

-- Chuyen du lieu cu: lich active thanh PENDING; lich inactive thanh CANCELLED.
-- Du lieu cu khong co ly do huy hay tien coc, nen cac cot moi dung gia tri mac dinh.
UPDATE Appointments
SET status = CASE WHEN is_active = TRUE THEN 'PENDING' ELSE 'CANCELLED' END;

ALTER TABLE Appointments
    MODIFY COLUMN status ENUM(
        'PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED'
    ) NOT NULL DEFAULT 'PENDING',
    DROP COLUMN is_active,
    ADD CONSTRAINT CK_Appointments_Deposit_NonNegative CHECK (deposit_amount >= 0),
    ADD CONSTRAINT CK_Appointments_Penalty_Range CHECK (
        penalty_fee >= 0 AND penalty_fee <= deposit_amount
    );

-- 2. Don thuoc: moi lich hen co toi da mot don trong thiet ke co ban (1-1).
CREATE TABLE Prescriptions (
    prescription_id INT NOT NULL AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    medication_details TEXT NOT NULL,
    issued_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_Prescriptions PRIMARY KEY (prescription_id),
    CONSTRAINT UQ_Prescriptions_Appointment UNIQUE (appointment_id),
    CONSTRAINT FK_Prescriptions_Appointments
        FOREIGN KEY (appointment_id)
        REFERENCES Appointments(appointment_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Chan tao don thuoc neu lich hen chua hoan tat.
DELIMITER $$
CREATE TRIGGER TRG_Prescriptions_OnlyCompleted
BEFORE INSERT ON Prescriptions
FOR EACH ROW
BEGIN
    DECLARE appointment_status VARCHAR(20);

    SELECT status
      INTO appointment_status
      FROM Appointments
     WHERE appointment_id = NEW.appointment_id;

    IF appointment_status IS NULL OR appointment_status <> 'COMPLETED' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Chi tao don thuoc cho lich hen da COMPLETED';
    END IF;
END$$
DELIMITER ;

-- 3. Du lieu mau phuc vu hai kich ban. Chay tren CSDL thu nghiem.
INSERT INTO Patients (full_name, phone)
VALUES ('Nguyen Van An', '0900000001');
SET @patient_success = LAST_INSERT_ID();

INSERT INTO Doctors (full_name, specialty)
VALUES ('Tran Thi Binh', 'Noi tong quat');
SET @doctor_id = LAST_INSERT_ID();

-- Kich ban 1: dat lich, xac nhan coc, den kham, hoan tat, ke don.
INSERT INTO Appointments
    (patient_id, doctor_id, appointment_date, status,
     deposit_amount, penalty_fee, cancel_reason)
VALUES
    (@patient_success, @doctor_id, DATE_ADD(NOW(), INTERVAL 1 DAY),
     'PENDING', 500000.00, 0.00, NULL);
SET @appointment_success = LAST_INSERT_ID();

UPDATE Appointments
SET status = 'CONFIRMED'
WHERE appointment_id = @appointment_success;

UPDATE Appointments
SET status = 'CHECKED_IN'
WHERE appointment_id = @appointment_success;

UPDATE Appointments
SET status = 'COMPLETED'
WHERE appointment_id = @appointment_success;

INSERT INTO Prescriptions (appointment_id, medication_details)
VALUES (@appointment_success,
        'Paracetamol 500mg: uong khi dau; dung theo chi dan bac si.');

-- Kich ban 2: da xac nhan coc, sau do huy va tru phi phat.
INSERT INTO Patients (full_name, phone)
VALUES ('Le Thi Mai', '0900000002');
SET @patient_cancel = LAST_INSERT_ID();

INSERT INTO Appointments
    (patient_id, doctor_id, appointment_date, status,
     deposit_amount, penalty_fee, cancel_reason)
VALUES
    (@patient_cancel, @doctor_id, DATE_ADD(NOW(), INTERVAL 2 DAY),
     'CONFIRMED', 300000.00, 0.00, NULL);
SET @appointment_cancel = LAST_INSERT_ID();

UPDATE Appointments
SET status = 'CANCELLED',
    cancel_reason = 'Ban viec dot xuat',
    penalty_fee = 150000.00
WHERE appointment_id = @appointment_cancel;

-- 4. Kiem tra trang thai, tien coc, phi phat va don thuoc.
SELECT a.appointment_id, p.full_name AS patient_name,
       d.full_name AS doctor_name, a.status,
       a.deposit_amount, a.penalty_fee, a.cancel_reason,
       a.deposit_amount - a.penalty_fee AS deposit_remaining,
       pr.prescription_id, pr.medication_details, pr.issued_date
FROM Appointments AS a
JOIN Patients AS p ON p.patient_id = a.patient_id
JOIN Doctors AS d ON d.doctor_id = a.doctor_id
LEFT JOIN Prescriptions AS pr ON pr.appointment_id = a.appointment_id
WHERE a.appointment_id IN (@appointment_success, @appointment_cancel)
ORDER BY a.appointment_id;

-- Kiem tra trigger (tuy chon): lenh sau phai bi tu choi vi lich dang PENDING.
-- INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, deposit_amount)
-- VALUES (@patient_success, @doctor_id, DATE_ADD(NOW(), INTERVAL 3 DAY), 'PENDING', 100000.00);
-- SET @pending_appointment = LAST_INSERT_ID();
-- INSERT INTO Prescriptions (appointment_id, medication_details)
-- VALUES (@pending_appointment, 'Don nay phai bi trigger tu choi');
