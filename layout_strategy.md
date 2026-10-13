# Chiến lược dàn trang MetricsHub

- **Navbar — Flexbox:** thanh điều hướng là bố cục một chiều. Flexbox căn logo, liên kết và tài khoản theo hàng, tự phân phối khoảng trống và cho phép menu xuống dòng trên màn hình hẹp.
- **Dashboard — CSS Grid:** dashboard cần kiểm soát đồng thời hàng và cột. Grid đặt các widget thành lưới ba cột; widget doanh thu chiếm hai cột và hai hàng bằng `grid-column: span 2` và `grid-row: span 2`. Ở tablet chuyển về hai cột, ở mobile chuyển thành một cột.
- **Bảng giá — Bootstrap:** dùng `container-fluid`, `row`, `col-12 col-md-4` và các lớp `card`. Mỗi gói chiếm toàn chiều rộng trên mobile, ba cột bằng nhau từ breakpoint md trở lên.

Flexbox phù hợp căn chỉnh theo một trục; Grid phù hợp bố cục hai chiều. Các công cụ có thể phối hợp trong cùng trang, miễn chọn theo nhu cầu của từng vùng.
