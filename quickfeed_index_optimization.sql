-- QuickFeed: đo dung lượng trước/sau và bỏ ba secondary index được xác định là dư thừa.
-- Chạy trên CSDL đã có bảng Posts cùng các index trong đề; chỉ chạy các lệnh DROP một lần.
USE quickfeed_db;

-- Kiểm tra cấu trúc index hiện tại và ghi nhận dung lượng trước tối ưu.
SHOW INDEX FROM Posts;
SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Posts';

-- Giữ idx_user_id và idx_created_at.
-- Xóa đúng ba index mục tiêu: prefix B-tree trên TEXT, post_type, is_visible.
ALTER TABLE Posts DROP INDEX idx_content;
ALTER TABLE Posts DROP INDEX idx_post_type;
ALTER TABLE Posts DROP INDEX idx_is_visible;

-- Cập nhật thống kê rồi ghi nhận lại sau tối ưu.
ANALYZE TABLE Posts;
SHOW INDEX FROM Posts;
SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Posts';

-- Chỉ số tiết kiệm index (MB) = index_mb trước - index_mb sau.
-- InnoDB trả về kích thước cấp phát/ước tính; có thể thay đổi theo phiên bản và dữ liệu.
