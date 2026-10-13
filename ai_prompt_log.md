# Nhật ký hỏi đáp AI — JOIN trong FlashMart

## 1. JOIN mặc định
**Prompt:** Trong MySQL, JOIN không ghi loại thì hoạt động như thế nào?  
**Tóm tắt:** JOIN mặc định là INNER JOIN, chỉ giữ các dòng có khóa ghép khớp ở cả hai bảng.

## 2. COUNT với LEFT JOIN
**Prompt:** Vì sao báo cáo khách hàng cần COUNT(o.order_id) thay vì COUNT(*)?  
**Tóm tắt:** COUNT(cột) bỏ qua NULL. Khách chưa có đơn được LEFT JOIN tạo một dòng có o.order_id NULL, nên COUNT(o.order_id) là 0. COUNT(*) vẫn đếm dòng đó thành 1.

## 3. Anti-join
**Prompt:** LEFT JOIN ... WHERE o.order_id IS NULL dùng để làm gì?  
**Tóm tắt:** Cách này lọc các bản ghi bảng trái không có bản ghi khớp ở bảng phải. NOT EXISTS cũng là lựa chọn rõ nghĩa; NOT IN có thể gây kết quả khó đoán nếu truy vấn con chứa NULL.

## 4. Hiệu năng
**Prompt:** LEFT JOIN ... IS NULL có luôn nhanh hơn NOT EXISTS không?  
**Tóm tắt:** Không có quy tắc luôn đúng. MySQL có thể tối ưu cả hai dạng; cần chỉ mục trên cột ghép và dùng EXPLAIN để xem kế hoạch thực thi với dữ liệu thực tế. Nested-loop join là một thuật toán phổ biến khi nối bảng.

## 5. FULL OUTER JOIN
**Prompt:** MySQL có hỗ trợ FULL OUTER JOIN trực tiếp không?  
**Tóm tắt:** MySQL không có cú pháp FULL OUTER JOIN trực tiếp. Có thể kết hợp LEFT JOIN và RIGHT JOIN bằng UNION, đồng thời tránh lặp các dòng đã khớp.
