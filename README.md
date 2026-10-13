USE QuanLySinhVien;

-- 1. Đếm số sinh viên ở từng nơi
SELECT Address, COUNT(StudentId) AS `Số lượng học viên`
FROM Student
GROUP BY Address;

-- 2. Tính điểm trung bình của từng học viên
SELECT S.StudentId, S.StudentName, AVG(M.Mark) AS `Điểm trung bình`
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;

-- 3. Học viên có điểm trung bình lớn hơn 15
SELECT S.StudentId, S.StudentName, AVG(M.Mark) AS `Điểm trung bình`
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) > 15;

-- 4. Học viên có điểm trung bình cao nhất
-- Nếu nhiều học viên đồng hạng cao nhất, truy vấn sẽ hiển thị tất cả.
SELECT S.StudentId, S.StudentName, AVG(M.Mark) AS `Điểm trung bình`
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) >= ALL (
    SELECT AVG(Mark)
    FROM Mark
    GROUP BY StudentId
);
