# Nhật ký prompt AI — QuickFeed Index

1. “Giải thích cardinality trong MySQL. Vì sao index trên BOOLEAN hoặc cột chỉ có vài giá trị có thể không giúp truy vấn lọc phần lớn bảng?”
   - Kết luận dùng: độ chọn lọc thấp khiến optimizer có thể chọn quét bảng; cần xét phân bố dữ liệu và mẫu truy vấn.

2. “Index B-tree prefix trên cột TEXT lưu trữ gì, hỗ trợ kiểu tìm kiếm nào, và hạn chế gì khi tìm chuỗi con?”
   - Kết luận dùng: prefix index lưu phần đầu của giá trị; tìm từ khóa toàn văn nên đánh giá FULLTEXT.

3. “Một INSERT vào InnoDB cần duy trì các index nào, và vì sao nhiều secondary index làm tăng chi phí ghi?”
   - Kết luận dùng: mỗi secondary index cần cập nhật bản ghi tương ứng; page split/cache khiến số I/O vật lý không cố định.

4. “Viết truy vấn information_schema.TABLES để đọc DATA_LENGTH và INDEX_LENGTH theo MB; giải thích đây có phải số đo thời gian chạy không.”
   - Kết luận dùng: chia byte cho 1024^2; ghi nhận cùng bảng trước và sau khi drop index.

5. “Trong bảng chỉ đọc hoặc lưu trữ lâu dài, trade-off của việc giữ nhiều index thay đổi thế nào?”
   - Kết luận dùng: ít ghi làm giảm chi phí bảo trì thường xuyên, nhưng index vẫn tiêu tốn storage và có thể ảnh hưởng bảo trì; chỉ giữ index phục vụ truy vấn cần thiết.
