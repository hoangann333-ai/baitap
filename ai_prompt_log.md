# Nhật ký sử dụng AI

Nhật ký dưới đây phản ánh phần hỗ trợ AI trong buổi làm bài này. Học viên hãy bổ sung thời điểm, công cụ sử dụng và kết quả chạy thực tế trước khi nộp.

1. **Yêu cầu gửi cho AI:** Học viên cung cấp đề bài HealthSync và nhờ hỗ trợ làm bài.  
   **Nội dung AI hỗ trợ:** Phân tích các điểm thiếu của thiết kế cũ: Boolean không lưu được vòng đời lịch hẹn; thiếu tiền cọc, phí phạt, lý do hủy; thiếu bảng đơn thuốc; khóa ngoại lịch hẹn cho phép NULL.

2. **Yêu cầu gửi cho AI:** Học viên đề nghị viết bài hoàn chỉnh.  
   **Nội dung AI hỗ trợ:** Soạn bản SQL migration và hai kịch bản DML; đề xuất `ENUM` cho trạng thái, `DECIMAL(10,2)` cho tiền, `CHECK` cho giới hạn phí phạt, `UNIQUE(appointment_id)` cho quan hệ một-một đơn thuốc, và trigger chặn kê đơn trước khi lịch hoàn tất.

3. **Việc học viên cần tự kiểm tra:** Chạy script trên MySQL phiên bản hỗ trợ CHECK, xác nhận hai kịch bản, thử trigger với lịch chưa COMPLETED, rồi ghi lại lỗi/kết quả thực tế tại đây.

> Không ghi rằng script đã chạy thành công nếu bạn chưa tự chạy. Hãy sửa nhật ký để khớp với thao tác và kết quả thật của bạn.
