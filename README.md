USE QuanLySinhVien;

-- 1. Môn học có credit lớn nhất
SELECT *
FROM Subject
WHERE Credit = (
    SELECT MAX(Credit)
    FROM Subject
);

-- 2. Môn học có điểm thi cao nhất
SELECT DISTINCT S.*
FROM Subject AS S
JOIN Mark AS M ON M.SubjectId = S.SubjectId
WHERE M.Mark = (
    SELECT MAX(Mark)
    FROM Mark
);

-- 3. Điểm trung bình của từng sinh viên, sắp xếp giảm dần
SELECT S.StudentId,
       S.StudentName,
       AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M ON M.StudentId = S.StudentId
GROUP BY S.StudentId, S.StudentName
ORDER BY AverageMark DESC;
