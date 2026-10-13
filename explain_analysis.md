# Phân tích EXPLAIN

Truy vấn cũ áp dụng `YEAR()` và `MONTH()` lên `created_at`, nên MySQL thường không thể dùng B-tree trên cột này để tìm trực tiếp khoảng ngày; kế hoạch có thể hiện `type = ALL` và ước tính `rows` gần toàn bảng. Đây là xu hướng kỳ vọng, không phải kết quả đo: bảng mẫu chưa có 5 triệu dòng nên cần ghi số thực tế từ MySQL.

Sau khi tạo `idx_type_date (transaction_type, created_at)` và đổi điều kiện thành `transaction_type = 'DEPOSIT'` cùng khoảng nửa mở từ 01/06/2026 đến trước 01/07/2026, MySQL có thể dùng `key = idx_type_date`, thường với `type = range`; số `rows` ước tính giảm theo lượng giao dịch khớp. Giá trị cụ thể phụ thuộc dữ liệu, thống kê và phiên bản/optimizer. Vì truy vấn cần `SUM(amount)` nhưng `amount` không nằm trong index, MySQL vẫn phải đọc giá trị hàng khớp; đây không phải covering index. Với InnoDB, SELECT thông thường không khóa toàn bảng theo kiểu table lock, dù quét lớn vẫn tiêu tốn I/O/CPU và có thể gây tranh chấp tài nguyên, tăng độ trễ.
