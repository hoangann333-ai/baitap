# Đối chiếu Activity Diagram và mô hình dữ liệu AutoRide

Thiết kế cũ chỉ lưu trạng thái bằng `VARCHAR`, không giới hạn giá trị; vì vậy trạng thái có thể sai chính tả hoặc không thuộc luồng nghiệp vụ. Bảng `Rentals` cũng thiếu tiền cọc, phí trả trễ và phí hư hỏng, nên hệ thống không thể tính khoản hoàn cho khách. Bảng cũ chưa có `Inspections`, khiến mô tả hư hỏng và người kiểm tra phải ghi ngoài hệ thống. Ngoài ra, thiếu thời điểm trả dự kiến khiến việc xác định khách có trả trễ hay không không có căn cứ thời gian.

Thiết kế mới dùng `ENUM` cho bốn trạng thái, `DECIMAL(10,2)` cho các khoản tiền, và `CHECK` để ngăn phí âm. `Inspections` lưu ngày kiểm tra, nội dung hư hỏng và nhân viên kiểm tra; quan hệ được chọn là Rentals 1-N Inspections vì một hợp đồng có thể cần kiểm tra lúc giao xe, lúc nhận lại hoặc tái kiểm tra. Khóa ngoại dùng `ON DELETE RESTRICT` để không xóa hợp đồng còn biên bản. Tiền hoàn được truy vấn bằng tiền cọc trừ phí trễ và phí hư hỏng.
