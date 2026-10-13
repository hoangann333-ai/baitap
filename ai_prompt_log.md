# Nhật ký prompt AI — SmartFactory

1. “Giải thích covering index trong InnoDB: vì sao SELECT có thể tránh tra cứu clustered index, và chi phí lưu trữ/ghi là gì?”
   - Ghi nhận: index chứa toàn bộ cột truy vấn cần có thể bao phủ SELECT; mỗi secondary index làm tăng công việc ghi và dung lượng.

2. “InnoDB lưu clustered index và secondary index khác nhau thế nào? Khi INSERT, có phải toàn bộ B-tree được sắp xếp lại không?”
   - Ghi nhận: secondary index lưu khóa và khóa chính để truy về hàng; không sắp xếp lại toàn cây sau mỗi INSERT, nhưng có cập nhật trang và đôi khi page split.

3. “Với bộ lọc `sensor_id = ?` và `recorded_at >= ?`, vì sao thứ tự `(sensor_id, recorded_at)` phù hợp?”
   - Ghi nhận: điều kiện bằng đặt trước điều kiện range giúp dùng leftmost prefix của composite index.

4. “Trong `EXPLAIN`, `Using index` và `Using index condition` khác gì? `rows` có phải số thực đo không?”
   - Ghi nhận: `Using index` chỉ covering access; `rows` là ước tính của optimizer.

5. “Nếu `status VARCHAR(20)` đổi sang `TINYINT`, cần cân nhắc gì về dung lượng?”
   - Ghi nhận: TINYINT dùng 1 byte; VARCHAR chiếm byte theo dữ liệu thực cộng metadata/charset, nên mức tiết kiệm tùy giá trị và encoding.
