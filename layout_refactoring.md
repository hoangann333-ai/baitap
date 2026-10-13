# Báo cáo tái cấu trúc giao diện CreativeChronicle

Bản cũ có ba vấn đề chính. Thanh tác giả dùng `float`, nên ảnh, thông tin và nút chia sẻ khó căn giữa theo chiều dọc; phần tử cha còn phải xử lý hiện tượng float collapse. Thư viện ảnh dùng `position: absolute` cùng chiều cao cố định, khiến ảnh thoát khỏi luồng tài liệu và có thể chồng lên nội dung khi màn hình hẹp. Danh sách bài đề xuất tự chia cột bằng float và phần trăm nên dễ rớt dòng sai.

Bản mới dùng Flexbox cho thanh tác giả, CSS Grid với `grid-template-areas` cho ảnh chính và hai ảnh phụ, và Bootstrap `row` / `col-12 col-md-6 col-lg-3` cho bốn thẻ bài viết. Trên điện thoại, ảnh khảm chuyển thành một cột; Bootstrap xếp bài viết thành một cột, trên tablet thành hai cột và trên desktop thành bốn cột. Grid giữ được quan hệ hai chiều giữa các ảnh trong khi vẫn cho phép tự tạo hàng mới nếu bổ sung ảnh.
