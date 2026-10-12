-- Cac truy van cho CSDL QuanLySinhVien
USE QuanLySinhVien;

-- 1. Danh sach tat ca hoc vien
SELECT *
FROM Student;

-- 2. Danh sach hoc vien dang theo hoc (Status = 1 / TRUE)
SELECT *
FROM Student
WHERE Status = 1;

-- 3. Danh sach mon hoc co thoi gian hoc nho hon 10 gio
SELECT *
FROM Subject
WHERE Credit < 10;

-- 4. Danh sach hoc vien lop A1
SELECT
    S.StudentID,
    S.StudentName,
    S.Address,
    S.Phone,
    S.Status,
    C.ClassName
FROM Student AS S
INNER JOIN Class AS C ON S.ClassID = C.ClassID
WHERE C.ClassName = 'A1';

-- 5. Diem mon CF cua cac hoc vien
SELECT
    S.StudentID,
    S.StudentName,
    Sub.SubName,
    M.Mark,
    M.ExamTimes
FROM Student AS S
INNER JOIN Mark AS M ON S.StudentID = M.StudentID
INNER JOIN Subject AS Sub ON M.SubID = Sub.SubID
WHERE Sub.SubName = 'CF';
