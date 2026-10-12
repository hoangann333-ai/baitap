# Nhật ký trao đổi AI — AutoRide

## 1. Chọn kiểu dữ liệu cho tiền
**Prompt:** Vì sao tiền cọc và các khoản phí nên dùng DECIMAL thay vì FLOAT/DOUBLE?  
**Tóm tắt:** DECIMAL lưu số thập phân chính xác theo chữ số quy định, phù hợp tiền và phép đối soát. FLOAT/DOUBLE có thể có sai số biểu diễn nhị phân. Bài dùng DECIMAL(10,2).

## 2. Biểu diễn vòng đời hợp đồng
**Prompt:** Dùng ENUM cho status có phù hợp với các trạng thái BOOKED, ACTIVE, COMPLETED, CANCELLED không?  
**Tóm tắt:** ENUM hạn chế dữ liệu vào đúng tập trạng thái đã định nghĩa, giảm lỗi nhập và giúp schema khớp quy trình. Khi trạng thái thay đổi thường xuyên hoặc do quản trị viên cấu hình, có thể cân nhắc bảng danh mục trạng thái.

## 3. Quan hệ giữa Rentals và Inspections
**Prompt:** Bảng biên bản kiểm tra xe nên là quan hệ 1-1 hay 1-N với hợp đồng thuê?  
**Tóm tắt:** Chọn 1-N: một hợp đồng có thể có biên bản khi giao xe, khi nhận xe và khi tái kiểm tra. Mỗi biên bản thuộc về một hợp đồng. Khóa ngoại dùng ON DELETE RESTRICT để giữ lịch sử kiểm tra.

## 4. Tính tiền hoàn và xử lý NULL
**Prompt:** Làm sao tránh kết quả tiền hoàn bị NULL khi một hợp đồng chưa có phí?  
**Tóm tắt:** Khai báo các khoản tiền NOT NULL DEFAULT 0.00 giúp phép trừ luôn có giá trị; nếu cho phép NULL thì cần dùng COALESCE. Truy vấn mẫu tính security_deposit - late_fee - damage_fee.

## 5. Bảo toàn dữ liệu hiện có
**Prompt:** Cú pháp ALTER TABLE nào đổi status sang ENUM và thêm các cột phí mà không xóa dữ liệu cũ?  
**Tóm tắt:** Dùng ALTER TABLE ... MODIFY COLUMN và ADD COLUMN. Cần kiểm tra các giá trị status hiện có trước khi chuyển kiểu để bảo đảm chúng nằm trong tập ENUM.
