-- Them du lieu va truy van CSDL QuanLyBanHang
-- Tuong thich voi schema da tao truoc: Customer.cName, Order.oTotalPrice.
-- Chay mot lan tren cac bang dang trong.
USE QuanLyBanHang;

-- De cho phep gia tri NULL ban dau (gia hoa don se duoc tinh tu OrderDetail).
ALTER TABLE `Order`
MODIFY COLUMN oTotalPrice DECIMAL(12, 2) NULL DEFAULT NULL;

-- 1. Them khach hang
INSERT INTO Customer (cID, cName, cAge)
VALUES
    (1, 'Minh Quan', 10),
    (2, 'Ngoc Oanh', 20),
    (3, 'Hong Ha', 50);

-- 2. Them san pham
INSERT INTO Product (pID, pName, pPrice)
VALUES
    (1, 'May Giat', 3),
    (2, 'Tu Lanh', 5),
    (3, 'Dieu Hoa', 7),
    (4, 'Quat', 1),
    (5, 'Bep Dien', 2);

-- 3. Them hoa don (oTotalPrice de NULL theo du lieu de bai)
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice)
VALUES
    (1, 1, '2006-03-21 00:00:00', NULL),
    (2, 2, '2006-03-23 00:00:00', NULL),
    (3, 1, '2006-03-16 00:00:00', NULL);

-- 4. Them chi tiet hoa don
INSERT INTO OrderDetail (oID, pID, odQTY)
VALUES
    (1, 1, 3),
    (1, 3, 7),
    (1, 4, 2),
    (2, 1, 1),
    (2, 2, 3),
    (2, 3, 1),
    (2, 4, 8),
    (2, 5, 4),
    (3, 2, 3);

-- 5. Hien thi ma hoa don, ngay mua va tong tien dang luu
SELECT oID, oDate, oTotalPrice AS oPrice
FROM `Order`
ORDER BY oID;

-- 6. Danh sach khach hang va cac san pham ho da mua
SELECT
    c.cID,
    c.cName,
    o.oID,
    p.pID,
    p.pName,
    od.odQTY
FROM Customer AS c
INNER JOIN `Order` AS o ON o.cID = c.cID
INNER JOIN OrderDetail AS od ON od.oID = o.oID
INNER JOIN Product AS p ON p.pID = od.pID
ORDER BY c.cID, o.oID, p.pID;

-- 7. Khach hang chua mua bat ky san pham nao
SELECT c.cID, c.cName, c.cAge
FROM Customer AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM `Order` AS o
    INNER JOIN OrderDetail AS od ON od.oID = o.oID
    WHERE o.cID = c.cID
)
ORDER BY c.cID;

-- 8. Tong tien tung hoa don = SUM(so luong * gia san pham)
SELECT
    o.oID,
    o.oDate,
    COALESCE(SUM(od.odQTY * p.pPrice), 0) AS oPrice
FROM `Order` AS o
LEFT JOIN OrderDetail AS od ON od.oID = o.oID
LEFT JOIN Product AS p ON p.pID = od.pID
GROUP BY o.oID, o.oDate
ORDER BY o.oID;

-- Ket qua tinh tong tien theo du lieu mau: hoa don 1 = 60,
-- hoa don 2 = 41, hoa don 3 = 15.
