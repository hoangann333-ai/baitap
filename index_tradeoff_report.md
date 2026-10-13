# SmartFactory: báo cáo đánh đổi Index

Fat index `(sensor_id, recorded_at, temperature, humidity, status)` có thể bao phủ truy vấn Dashboard, tránh tra cứu clustered index để lấy ba cột kết quả. Tuy nhiên, mỗi bản ghi cảm biến mới cũng phải thêm mục vào từng secondary index; index rộng hơn làm tăng dung lượng lưu trữ, dữ liệu cần ghi và áp lực lên cache. InnoDB không sắp xếp lại toàn bộ cây ở mỗi INSERT; page split xảy ra khi cần, nên mức chậm và tỷ lệ tiết kiệm phải đo thực tế.

Đã thay bằng lean index `(sensor_id, recorded_at)`: hai cột lọc vẫn hỗ trợ tìm theo cảm biến và khoảng thời gian. Dashboard phải tra cứu hàng trong bảng để lấy `temperature`, `humidity`, `status`, nên có thể chậm hơn một chút. Đổi lại, index nhỏ hơn và ít dữ liệu phụ phải duy trì cho mỗi lần ghi. Index có lợi hơn khi workload chủ yếu đọc và dữ liệu ít thay đổi; vẫn cần cân bằng theo truy vấn thực tế.

| Chỉ số | Trước | Sau |
|---|---:|---:|
| Index_length (MB) | [điền kết quả] | [điền kết quả] |
| Data_length (MB) | [điền kết quả] | [điền kết quả] |
| Index giảm (MB) | — | [trước − sau] |

Chưa chạy trên dữ liệu nhà máy thật, vì vậy không khẳng định mức giảm 70% hoặc INSERT nhanh gấp 5 lần. Ghi số đo từ `information_schema.TABLES`; `EXPLAIN` cho thấy kế hoạch và ước tính, không đo trực tiếp thời gian chạy.
