## Xoá cơ sở dữ liệu bằng câu lệnh SQL trên MySQL Workbench

### Bước 1: Tạo CSDL rỗng và kiểm tra trước khi xoá

```sql
CREATE DATABASE thuc_hanh_xoa_sql;
SHOW DATABASES LIKE 'thuc_hanh_xoa_sql';
<img width="1920" height="1080" alt="Screenshot (2540)" src="https://github.com/user-attachments/assets/46ef2202-ca70-4f45-9fce-429efda5f46f" />
DROP DATABASE thuc_hanh_xoa_sql;
<img width="1920" height="1080" alt="Screenshot (2541)" src="https://github.com/user-attachments/assets/017f53d6-f7c0-47ea-8082-feedabc42c4e" />
SHOW DATABASES LIKE 'thuc_hanh_xoa_sql';
<img width="1920" height="1080" alt="Screenshot (2542)" src="https://github.com/user-attachments/assets/3d202941-763b-4c89-aae9-f61e5c3c9ea9" />

**Lưu ý khi sao chép:** lấy toàn bộ nội dung mẫu, gồm các dòng dấu ``` để GitHub hiển thị đúng đoạn SQL.

**6. Nộp lại**

Bấm **Commit changes** để lưu README → quay lại **bài 336** → chọn **Nộp lại**, dùng link README của bạn.

**Bạn cần thực thi và chụp ba ảnh thật; chỉ thêm câu lệnh vào README vẫn chưa đủ minh chứng cho phần đang thiếu.**
