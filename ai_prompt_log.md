# Nhật ký prompt AI

1. “Trong MySQL, nếu tạo index cho cột ngày nhưng viết `WHERE YEAR(created_at) = 2026`, vì sao optimizer khó dùng index? Giải thích SARGable bằng ví dụ, không viết hộ toàn bộ truy vấn.”
2. “Với index `(transaction_type, created_at)`, giải thích vai trò thứ tự cột và vì sao điều kiện bằng trên loại giao dịch đứng trước điều kiện range theo ngày.”
3. “Trong EXPLAIN MySQL, phân biệt `ALL`, `range`, `ref`, `possible_keys`, `key`, `rows` và `Extra`; `rows` là ước tính hay số đo thực tế?”
4. “Phân biệt `Using index condition` với `Using index` (covering index) trong EXPLAIN.”
5. “Giải thích rủi ro vận hành khi thêm nhiều index vào bảng có tần suất INSERT/UPDATE/DELETE cao.”
6. “MySQL 8 dùng lệnh nào để xem actual rows và thời gian thực thi; khác gì với EXPLAIN thường?”

## Ghi chú

AI được dùng để giải thích khái niệm và kiểm tra cách hiểu. Truy vấn SQL trong bài được học viên tự phân tích theo yêu cầu; không đưa lỗi SQL lên AI để yêu cầu tạo câu lệnh nhanh nhất.
