## Mô hình ERD quản lý đơn đặt hàng

### 1. Các thực thể và thuộc tính
Thuộc tính định danh được ghi trước mỗi danh sách.

- ĐƠN VỊ KHÁCH: Mã ĐV, Tên ĐV, Địa chỉ, Điện thoại.
- NGƯỜI ĐẶT: Mã số NĐ, Họ tên NĐ.
- NGƯỜI NHẬN: Mã số NN, Họ tên NN.
- HÀNG: Mã hàng, Tên hàng, Đơn vị tính, Mô tả hàng.
- NGƯỜI GIAO: Mã số NG, Họ tên NG.
- NƠI GIAO: Mã số ĐĐG, Tên nơi giao.

### 2. Các mối quan hệ

- THUỘC 1: Người đặt thuộc Đơn vị khách.
  Một đơn vị khách có nhiều người đặt;
  mỗi người đặt thuộc một đơn vị khách.

- THUỘC 2: Người nhận thuộc Đơn vị khách.
  Một đơn vị khách có nhiều người nhận;
  mỗi người nhận thuộc một đơn vị khách.

- ĐẶT: liên kết Người đặt và Hàng.
  Các thuộc tính của quan hệ: Số ĐH, Ngày đặt, Số lượng.

- GIAO: liên kết Người giao, Hàng, Người nhận và Nơi giao.
  Các thuộc tính của quan hệ: Số PG, Ngày giao,
  Số lượng, Đơn giá.
  Thành tiền được tính bằng Số lượng × Đơn giá.

### 3. Rút gọn mô hình

Gộp Đơn vị đặt hàng và Đơn vị khách hàng thành
Đơn vị khách vì cả hai đều là các đơn vị bên ngoài
giao dịch với cửa hàng.

Đơn vị khách có đủ thuộc tính:
Mã ĐV, Tên ĐV, Địa chỉ, Điện thoại.

### 4. Ký hiệu trên sơ đồ

- Hình chữ nhật: thực thể.
- Hình oval: thuộc tính.
- Hình thoi: mối quan hệ.
- Thuộc tính gạch chân: thuộc tính định danh.
- 1 và N: lực lượng liên kết.
<img width="2400" height="2100" alt="download" src="https://github.com/user-attachments/assets/beca1908-e062-4eca-916f-a224df131393" />
