# Nhật ký sử dụng AI

1. **Câu hỏi:** Navbar có các liên kết dài, nên dùng Flexbox hay Grid?
   **Kết luận:** Flexbox phù hợp vì navbar là một hàng linh hoạt; dùng `flex-wrap` để các mục có thể xuống dòng khi thiếu chỗ.

2. **Câu hỏi:** Widget lớn cần chiếm hai cột và hai hàng thì nên bố trí thế nào?
   **Kết luận:** Dùng CSS Grid với `grid-column: span 2` và `grid-row: span 2`; các widget còn lại là phần tử ngang hàng trong cùng grid container.

3. **Câu hỏi:** Dùng Bootstrap thế nào để ba thẻ giá xếp dọc trên điện thoại và thành ba cột trên desktop?
   **Kết luận:** Đặt mỗi thẻ trong `col-12 col-md-4` bên trong `row`. Bootstrap cung cấp breakpoint và lưới responsive sẵn.

4. **Câu hỏi:** Có thể kết hợp Grid, Flexbox và Bootstrap không?
   **Kết luận:** Có. Bài này dùng Grid cho vùng dashboard, Flexbox cho navbar và lưới Bootstrap cho bảng giá; Flexbox cũng có thể căn giữa nội dung bên trong một widget.
