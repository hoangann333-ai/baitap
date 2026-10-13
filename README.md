USE QuanLySinhVien;

-- 1. Hiển thị môn học có số tín chỉ lớn nhất
SELECT *
FROM Subject
WHERE Credit = (
    SELECT MAX(Credit)
    FROM Subject
);

-- 2. Hiển thị môn học có điểm thi cao nhất
SELECT DISTINCT S.*
FROM Subject AS S
JOIN Mark AS M ON M.SubjectId = S.SubjectId
WHERE M.Mark = (
    SELECT MAX(Mark)
    FROM Mark
);

-- 3. Hiển thị sinh viên và điểm trung bình, xếp từ cao xuống thấp
SELECT S.StudentId,
       S.StudentName,
       AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M ON M.StudentId = S.StudentId
GROUP BY S.StudentId, S.StudentName
ORDER BY AverageMark DESC;
