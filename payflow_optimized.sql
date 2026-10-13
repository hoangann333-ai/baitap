-- PayFlow: so sánh kế hoạch cũ và mới.
-- Chạy trên MySQL 8.x. Bảng mẫu cần được nạp dữ liệu trước khi đánh giá rows thực tế.
CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
) ENGINE=InnoDB;

-- 1) Baseline: hàm trên cột ngày khiến điều kiện không SARGable.
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- 2) Composite B-tree index: cột điều kiện bằng (=) trước, cột khoảng sau.
CREATE INDEX idx_type_date
    ON Transactions (transaction_type, created_at);

-- 3) Tối ưu: khoảng nửa mở [đầu tháng, đầu tháng kế tiếp), không bỏ sót giờ/phần giây.
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';

-- Trên MySQL 8.0.18+, EXPLAIN ANALYZE thực thi truy vấn và báo số liệu thực tế.
-- Chạy riêng khi muốn đo thời gian / actual rows; đây không chỉ là dự đoán như EXPLAIN.
-- EXPLAIN ANALYZE
-- SELECT SUM(amount) AS total_deposit
-- FROM Transactions
-- WHERE transaction_type = 'DEPOSIT'
--   AND created_at >= '2026-06-01 00:00:00'
--   AND created_at <  '2026-07-01 00:00:00';
