# Phân tích lựa chọn JOIN trong FlashMart

Báo cáo Marketing phải giữ toàn bộ khách hàng, kể cả người chưa có đơn, nên `Customers` là bảng trái và dùng `LEFT JOIN Orders`. Với Charlie, các cột bên `Orders` là `NULL`. `COUNT(o.order_id)` chỉ đếm giá trị không NULL nên trả về 0. Nếu dùng `COUNT(*)`, dòng khách hàng vẫn được LEFT JOIN giữ lại và bị đếm thành 1, sai nghiệp vụ.

Báo cáo Kho vận cũng cần giữ toàn bộ sản phẩm trước khi lọc. `LEFT JOIN` từ `Products` sang `Orders`, rồi `WHERE o.order_id IS NULL`, tìm các sản phẩm không có đơn ghép tương ứng, ở đây là Keyboard. `INNER JOIN` chỉ giữ các bản ghi có khớp nên không thể tìm nhóm chưa từng bán bằng cách này.
