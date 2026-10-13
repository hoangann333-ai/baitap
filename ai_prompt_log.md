# Nhật ký sử dụng AI

1. **Hỏi:** Vì sao float thường cần clearfix và vì sao absolute có thể làm nội dung bên dưới bị đè?
   **Tóm tắt:** Float rời khỏi luồng bình thường một phần nên cha có thể không ôm chiều cao con; phần tử absolute bị loại khỏi luồng, không góp vào kích thước cha.

2. **Hỏi:** Grid có thể tạo ảnh khảm gồm một ảnh lớn và hai ảnh nhỏ như thế nào?
   **Tóm tắt:** Dùng `grid-template-areas` để đặt ảnh lớn ở hai hàng, hai ảnh còn lại ở cột bên cạnh; dùng `object-fit: cover` giữ ảnh phủ khung.

3. **Hỏi:** Bootstrap nên dùng breakpoint nào để bài viết thành 1, 2, rồi 4 cột?
   **Tóm tắt:** `col-12 col-md-6 col-lg-3`: toàn chiều rộng dưới md, hai cột từ md, bốn cột từ lg.

4. **Hỏi:** Vì sao Flexbox hợp với thanh tác giả?
   **Tóm tắt:** Đây là bố cục theo một trục; `align-items: center`, `justify-content: space-between` và `flex-wrap` căn hàng và xử lý màn hình hẹp.
