-- Truy van va cap nhat du lieu cho CSDL QuanLySinhVien
USE QuanLySinhVien;

-- 1. Sinh vien co ten bat dau bang ky tu h
-- LOWER giup truy van khong phu thuoc chu hoa/chu thuong.
SELECT *
FROM Student
WHERE LOWER(StudentName) LIKE 'h%';

-- 2. Cac lop co thoi gian bat dau trong thang 12 (bat ky nam nao)
SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;

-- 3. Mon hoc co Credit tu 3 den 5, tinh ca 3 va 5
SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;

-- 4. Chuyen sinh vien ten Hung sang lop co ClassID = 2
-- Gia su lop ClassID = 2 da ton tai va ten Hung la duy nhat trong du lieu mau.
SET @old_sql_safe_updates = @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;

UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

SET SQL_SAFE_UPDATES = @old_sql_safe_updates;

-- Kiem tra ket qua cap nhat
SELECT StudentID, StudentName, ClassID
FROM Student
WHERE StudentName = 'Hung';

-- 5. Hien thi ten sinh vien, ten mon hoc va diem;
-- sap xep diem giam dan, neu bang diem thi ten tang dan.
SELECT
    S.StudentName,
    Sub.SubName,
    M.Mark
FROM Student AS S
INNER JOIN Mark AS M
    ON S.StudentID = M.StudentID
INNER JOIN Subject AS Sub
    ON M.SubID = Sub.SubID
ORDER BY M.Mark DESC, S.StudentName ASC;
