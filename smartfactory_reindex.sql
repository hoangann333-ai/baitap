-- SmartFactory: đo trước/sau khi thay fat covering index bằng lean index.
-- Yêu cầu: smartfactory_db.SensorLogs và idx_fat_covering đang tồn tại theo đề.
USE smartfactory_db;

-- Đo và kiểm tra kế hoạch khi fat index còn tồn tại.
SHOW INDEX FROM SensorLogs;
SHOW TABLE STATUS LIKE 'SensorLogs';

SELECT TABLE_SCHEMA, TABLE_NAME,
       ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
       ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'SensorLogs';

EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20 00:00:00';

-- Thay index: bỏ cột payload khỏi index, chỉ giữ cột dùng để lọc.
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;
CREATE INDEX idx_lean_search
    ON SensorLogs (sensor_id, recorded_at);

ANALYZE TABLE SensorLogs;

-- Xác nhận kế hoạch mới vẫn dùng index lọc và cần đọc bảng để lấy payload.
EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20 00:00:00';

-- Đo dung lượng sau thay đổi, so sánh với kết quả trước đó.
SHOW INDEX FROM SensorLogs;
SHOW TABLE STATUS LIKE 'SensorLogs';

SELECT TABLE_SCHEMA, TABLE_NAME,
       ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
       ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'SensorLogs';

-- EXPLAIN estimates rows; run EXPLAIN ANALYZE separately on MySQL 8.0.18+
-- if actual row counts and execution time are required.
