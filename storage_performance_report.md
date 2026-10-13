# Báo cáo tối ưu lưu trữ và hiệu năng QuickFeed

Đã giữ `PRIMARY`, `idx_user_id`, `idx_created_at` và xóa `idx_content`, `idx_post_type`, `idx_is_visible`. Index B-tree trên `content(255)` chiếm thêm dung lượng và không phù hợp tìm chuỗi con tùy ý; tìm từ khóa nên cân nhắc `FULLTEXT`. `post_type` và `is_visible` có ít giá trị nên thường lọc kém theo giả định của bài. Cardinality thấp không tự động làm mọi index vô ích; cần xét phân bố dữ liệu và truy vấn thực tế.

Trước tối ưu, mỗi INSERT duy trì 5 secondary index ngoài clustered primary key; sau đó còn 2. InnoDB cần thêm ít nhất ba bản ghi index thứ cấp ít hơn cho mỗi bài, giảm công việc ghi và dung lượng index. Số lần ghi trang đĩa không nhất thiết bằng số index vì còn phụ thuộc cache, page split và I/O.

| Đo lường | Trước | Sau |
|---|---:|---:|
| Data (MB) | [điền kết quả] | [điền kết quả] |
| Index (MB) | [điền kết quả] | [điền kết quả] |
| Index tiết kiệm (MB) | — | [Trước − Sau] |

Chưa chạy trên CSDL thật nên cần điền các ô bằng kết quả hai lần truy vấn `information_schema.TABLES`; không dùng số giả định làm số đo.
