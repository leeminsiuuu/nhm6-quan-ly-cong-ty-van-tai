﻿USE master;
GO

-- Xóa cơ sở dữ liệu nếu đang sử dụng
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'QuanLyVanTai1')
BEGIN
    ALTER DATABASE QuanLyVanTai1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QuanLyVanTai1;
END
GO

-- Tạo cơ sở dữ liệu
CREATE DATABASE QuanLyVanTai5;
GO
USE QuanLyVanTai5;
GO

-- Bảng Khách hàng
CREATE TABLE KhachHang (
    KhachHangID INT PRIMARY KEY,
    Ten NVARCHAR(50),
    DiaChi NVARCHAR(50), 
    SoDienThoai VARCHAR(50)
);

-- Bảng Tài xế
CREATE TABLE TaiXe (
    TaiXeID INT PRIMARY KEY,
    Ten NVARCHAR(50),  
    SoDienThoai VARCHAR(50)
);

-- Bảng Phương tiện
CREATE TABLE PhuongTien (
    PhuongTienID INT PRIMARY KEY,
    LoaiPhuongTien NVARCHAR(50),  
    BienSoXe NVARCHAR(50)         
);

-- Bảng Lịch trình vận hành
CREATE TABLE LichTrinhVanHanh (
    LichTrinhID INT PRIMARY KEY,
    KhachHangID INT,
    TaiXeID INT,
    PhuongTienID INT,
    NgayGioBatDau DATETIME,
    NgayGioKetThuc DATETIME,
    FOREIGN KEY (KhachHangID) REFERENCES KhachHang(KhachHangID),
    FOREIGN KEY (TaiXeID) REFERENCES TaiXe(TaiXeID),
    FOREIGN KEY (PhuongTienID) REFERENCES PhuongTien(PhuongTienID)
);

-- Bảng Lịch sử bảo trì
CREATE TABLE LichSuBaoTri (
    BaoTriID INT PRIMARY KEY,
    PhuongTienID INT,
    MoTa NVARCHAR(50),  -- Thay đổi sang NVARCHAR
    NgayBaoTri DATETIME,
    FOREIGN KEY (PhuongTienID) REFERENCES PhuongTien(PhuongTienID)
);

-- Nhập dữ liệu vào bảng Khách hàng
INSERT INTO KhachHang (KhachHangID, Ten, DiaChi, SoDienThoai) 
VALUES
(1, N'Trần Đình Nam', N'Hà Nam', N'0901234567'),
(2, N'Hà Phi Hùng', N'Hưng Yên', N'0912345678'),
(3, N'Lươn Đình Nam', N'Hà Nội', N'0923456789');
SELECT * FROM KhachHang;

-- Nhập dữ liệu vào bảng Tài xế
INSERT INTO TaiXe (TaiXeID, Ten, SoDienThoai) 
VALUES
(1, 'Trần Đình Nam', '0934567890'),
(2, 'Hà Phi Hùng', '0945678901'),
(3, 'Lươn Đình Nam', '0956789012');
GO

-- Nhập dữ liệu vào bảng Phương tiện
INSERT INTO PhuongTien (PhuongTienID, LoaiPhuongTien, BienSoXe) 
VALUES
(1, 'Xe tải', '29A-12345'),
(2, 'Xe container', '29B-99999'),
(3, 'Xe khách', '29C-56789');
GO

-- Nhập dữ liệu vào bảng Lịch trình vận hành
INSERT INTO LichTrinhVanHanh (LichTrinhID, KhachHangID, TaiXeID, PhuongTienID, NgayGioBatDau, NgayGioKetThuc) 
VALUES
(1, 1, 1, 1, '2024-11-20 08:00:00', '2024-11-20 10:00:00'),
(2, 2, 2, 2, '2024-11-21 09:00:00', '2024-11-21 12:00:00'),
(3, 3, 3, 3, '2024-11-22 07:30:00', '2024-11-22 09:30:00');
GO

-- Nhập dữ liệu vào bảng Lịch sử bảo trì
INSERT INTO LichSuBaoTri (BaoTriID, PhuongTienID, MoTa, NgayBaoTri)
VALUES
(1, 1, 'Thay dầu động cơ', '2024-10-15 14:00:00'),
(2, 2, 'Kiểm tra hệ thống phanh', '2024-11-01 10:30:00'),
(3, 3, 'Thay lốp xe', '2024-11-05 08:00:00');
GO

-- Chức năng chèn--

-- Chèn thông tin khách hàng:
INSERT INTO KhachHang (KhachHangID, Ten, DiaChi, SoDienThoai)
VALUES (4, 'Nguyễn Văn Nam', 'Hà Nội', '0961234567');

-- Chèn thông tin tài xế:
INSERT INTO TaiXe (TaiXeID, Ten, SoDienThoai)
VALUES (4, 'Hùng Top 1', '0972345678');

-- Chèn thông tin phương tiện:
INSERT INTO PhuongTien (PhuongTienID, LoaiPhuongTien, BienSoXe)
VALUES (4, 'Xe Con', '79C-12345');

-- Chèn lịch trình vận hành:
INSERT INTO LichTrinhVanHanh (LichTrinhID, KhachHangID, TaiXeID, PhuongTienID, NgayGioBatDau, NgayGioKetThuc)
VALUES (4, 4, 4, 4, '2024-11-20 08:00:00', '2024-11-20 10:00:00');

-- Chèn lịch sử bảo trì:
INSERT INTO LichSuBaoTri (BaoTriID, PhuongTienID, MoTa, NgayBaoTri)
VALUES (4, 4, 'Bảo trì định kỳ', '2024-11-15 09:00:00');

-- Sửa--

-- Sửa Thông Tin khách
UPDATE KhachHang
SET Ten ='Trần Đình Nam', DiaChi = 'Hà Nam', SoDienThoai = '0912345678'
WHERE KhachHangID = 1;

-- Sửa tt tài xế
UPDATE TaiXe
SET SoDienThoai = '0923456789'
WHERE TaiXeID = 1;

-- Sửa thông tin phương tiện:
UPDATE PhuongTien
SET LoaiPhuongTien = 'Xe Con'
WHERE PhuongTienID = 1;

-- Sửa lịch trình vận hành:
UPDATE LichTrinhVanHanh
SET NgayGioKetThuc = '2024-11-20 11:00:00'
WHERE LichTrinhID = 1;

-- Sửa lịch sử bảo trì:
UPDATE LichSuBaoTri
SET MoTa = 'Bảo trì sửa chữa'
WHERE BaoTriID = 1;

-- 1 Chỉnh sửa địa chỉ thông tin của khách hàng theo tên:
UPDATE KhachHang
SET DiaChi = 'Hà Nam'
WHERE Ten = 'Trần Đình Nam'; 

-- 2 Chỉnh sửa số điện thoại của tài xế theo tên:
UPDATE TaiXe
SET SoDienThoai =  '0956789012'
WHERE Ten = 'Lươn Đình Nam'; 

-- 3 Sửa biển số xe tiện theo ID phương tiện:
UPDATE PhuongTien
SET BienSoXe = '29A-12345'
WHERE PhuongTienID = 1;

-- 4 Chỉnh sửa thời gian bắt đầu của lịch vận hành theo lịch ID:
UPDATE LichTrinhVanHanh
SET NgayGioBatDau = '2024-11-20 07:00:00'
WHERE LichTrinhID = 2; 

-- 5 Chỉnh sửa mô tả lịch sử bảo trì theo ID bảo trì:
UPDATE LichSuBaoTri
SET MoTa = 'Thay thế phanh xe'
WHERE BaoTriID = 2;

-- Chức năng xóa--

-- Xóa thông tin khách hàng:
DELETE FROM KhachHang
WHERE KhachHangID = 1;

-- Xóa thông tin tài xế:
DELETE FROM TaiXe
WHERE TaiXeID = 1;

-- Xóa thông tin phương tiện:
DELETE FROM PhuongTien
WHERE PhuongTienID = 1;

-- Xóa lịch trình vận hành:
DELETE FROM LichTrinhVanHanh
WHERE LichTrinhID = 1;

-- Xóa lịch sử bảo trì:
DELETE FROM LichSuBaoTri
WHERE BaoTriID = 1;

-- 1 Xóa thông tin khách hàng theo số điện thoại:
DELETE FROM KhachHang
WHERE SoDienThoai = '0901234567';

-- 2 Xóa tài khoản thông tin theo tên:
DELETE FROM TaiXe
WHERE Ten = 'Trần Đình Nam';

-- 3 Xóa tất cả các tiện ích có trạng thái 'Dang bảo trì':
DELETE FROM PhuongTien
WHERE PhuongTienID IN (
    SELECT PhuongTienID FROM LichSuBaoTri
);

-- 4 Xóa tất cả hoạt động lịch trình của một tài xế:
DELETE FROM LichTrinhVanHanh
WHERE TaiXeID = 2; -- Thay đổi ID theo tài xế cụ thể

-- 5 Xóa tất cả lịch sử của một tiện ích phương tiện:
DELETE FROM LichSuBaoTri
WHERE PhuongTienID = 3; -- Thay đổi ID theo phương tiện cụ thể

-- Truy Vấn--
-- Tính tổng số chuyến đi của mỗi tài xế, nhóm theo mã tài xế và sắp xếp theo tổng số chuyến đi giảm dần.
SELECT TaiXeID, COUNT(*) AS TongChuyenDi
FROM LichTrinhVanHanh
GROUP BY TaiXeID
ORDER BY TongChuyenDi DESC;

-- Lấy thông tin lịch trình của những chuyến đi có thời gian bắt đầu sau ngày 1 tháng 1 năm 2024, kết quả sắp xếp theo ngày giờ bắt đầu.
SELECT LichTrinhID, KhachHangID, TaiXeID, PhuongTienID, NgayGioBatDau
FROM LichTrinhVanHanh
WHERE NgayGioBatDau > '2024-01-01'
ORDER BY NgayGioBatDau;

-- 4 Truy vấn lịch trình vận hành kèm thông tin khách hàng, tài xế và phương tiện:
SELECT LichTrinhVanHanh.*, 
       KhachHang.Ten AS TenKhachHang, 
       TaiXe.Ten AS TenTaiXe, 
       PhuongTien.BienSoXe
FROM LichTrinhVanHanh
JOIN KhachHang ON LichTrinhVanHanh.KhachHangID = KhachHang.KhachHangID
JOIN TaiXe ON LichTrinhVanHanh.TaiXeID = TaiXe.TaiXeID
JOIN PhuongTien ON LichTrinhVanHanh.PhuongTienID = PhuongTien.PhuongTienID;

-- 5 Tính giá trị trung bình số chuyến đi của mỗi khách hàng, nhóm theo mã khách hàng.
SELECT KhachHangID, AVG(TongChuyenDi) AS GiaTriTrungBinh
FROM (
    SELECT KhachHangID, COUNT(*) AS TongChuyenDi
    FROM LichTrinhVanHanh
    GROUP BY KhachHangID
) AS SubQuery
GROUP BY KhachHangID;

-- 6 Truy vấn sđt khách hàng
SELECT SoDienThoai FROM KhachHang;

-- 8 Truy vấn tất cả các phương tiện có loại 'Xe khách':
SELECT * FROM PhuongTien WHERE LoaiPhuongTien = 'Xe Khách';

-- 9 Truy vấn hành động lịch trình trong một khoảng thời gian cụ thể:
SELECT * FROM LichTrinhVanHanh 
WHERE NgayGioBatDau BETWEEN '2024-11-01' AND '2024-11-30';

-- 10 Truy vấn số lượng chuyến đi của mỗi tài xế:
SELECT TaiXeID, COUNT(LichTrinhID) AS SoChuyen
FROM LichTrinhVanHanh
GROUP BY TaiXeID;

-- 11 Truy vấn khách hàng có ít nhất một hành động lịch trình:
SELECT DISTINCT KhachHang.*
FROM KhachHang
JOIN LichTrinhVanHanh ON KhachHang.KhachHangID = LichTrinhVanHanh.KhachHangID;

-- 12 Lấy mã lịch trình và tên tài xế cho các chuyến đi mà tài xế đã thực hiện ít nhất 1 chuyến.
SELECT l.LichTrinhID, t.Ten
FROM LichTrinhVanHanh l
JOIN TaiXe t ON l.TaiXeID = t.TaiXeID
GROUP BY l.LichTrinhID, t.Ten
HAVING COUNT(l.LichTrinhID) >= 1;

-- 13 Tìm khách hàng có số chuyến đi lớn nhất và hiển thị tên khách hàng cùng tổng số chuyến đi.
SELECT TOP 1 kh.Ten, COUNT(l.LichTrinhID) AS TongChuyenDi
FROM KhachHang kh
JOIN LichTrinhVanHanh l ON kh.KhachHangID = l.KhachHangID
GROUP BY kh.Ten
ORDER BY TongChuyenDi DESC;

-- 14 Truy vấn lịch trình vận hành sắp xếp theo ngày bắt đầu:
SELECT * FROM LichTrinhVanHanh 
ORDER BY NgayGioBatDau ASC;

-- 15 Truy vấn tổng số phương tiện theo loại:
SELECT LoaiPhuongTien, COUNT(*) AS TongSo
FROM PhuongTien
GROUP BY LoaiPhuongTien;

-- 19 Truy vấn lịch sử bảo trì của tất cả phương tiện
SELECT PhuongTienID, MoTa, NgayBaoTri
FROM LichSuBaoTri
ORDER BY NgayBaoTri DESC;




-- hệ quản trị 





--Tạo View
--khách hàng
CREATE VIEW ViewKhachHang AS
SELECT KhachHangID, Ten, DiaChi, SoDienThoai
FROM KhachHang;
--Tài xế
CREATE VIEW ViewTaiXe AS
SELECT TaiXeID, Ten, SoDienThoai
FROM TaiXe;
--tiện ích
CREATE VIEW ViewPhuongTien AS
SELECT PhuongTienID, LoaiPhuongTien, BienSoXe
FROM PhuongTien;
--Lịch trình
CREATE VIEW ViewLichTrinhVanHanh AS
SELECT LichTrinhID, KhachHang.Ten AS TenKhachHang, TaiXe.Ten AS TenTaiXe, PhuongTien.BienSoXe, NgayGioBatDau, NgayGioKetThuc
FROM LichTrinhVanHanh
JOIN KhachHang ON LichTrinhVanHanh.KhachHangID = KhachHang.KhachHangID
JOIN TaiXe ON LichTrinhVanHanh.TaiXeID = TaiXe.TaiXeID
JOIN PhuongTien ON LichTrinhVanHanh.PhuongTienID = PhuongTien.PhuongTienID;
--bảo trì
CREATE VIEW ViewLichSuBaoTri AS
SELECT BaoTriID, PhuongTien.BienSoXe, MoTa, NgayBaoTri
FROM LichSuBaoTri
JOIN PhuongTien ON LichSuBaoTri.PhuongTienID = PhuongTien.PhuongTienID;
--Tổng hợp lịch trình theo tài xế
CREATE VIEW ViewTongHopLichTrinhTheoTaiXe AS
SELECT TaiXe.Ten AS TenTaiXe, COUNT(LichTrinhVanHanh.LichTrinhID) AS SoLichTrinh
FROM LichTrinhVanHanh
JOIN TaiXe ON LichTrinhVanHanh.TaiXeID = TaiXe.TaiXeID
GROUP BY TaiXe.Ten;
--Tổng hợp Bảo trì theo phương tiện
CREATE VIEW ViewTongHopBaoTriTheoPhuongTien AS
SELECT PhuongTien.BienSoXe, COUNT(LichSuBaoTri.BaoTriID) AS SoLanBaoTri
FROM LichSuBaoTri
JOIN PhuongTien ON LichSuBaoTri.PhuongTienID = PhuongTien.PhuongTienID
GROUP BY PhuongTien.BienSoXe;
--Lịch trình theo khách hàng
CREATE VIEW ViewLichTrinhTheoKhachHang AS
SELECT KhachHang.Ten AS TenKhachHang, LichTrinhVanHanh.NgayGioBatDau, LichTrinhVanHanh.NgayGioKetThuc
FROM LichTrinhVanHanh
JOIN KhachHang ON LichTrinhVanHanh.KhachHangID = KhachHang.KhachHangID;
--Chi tiết lịch trình 
CREATE VIEW ViewChiTietLichTrinh AS
SELECT LichTrinhVanHanh.LichTrinhID, KhachHang.Ten AS TenKhachHang, TaiXe.Ten AS TenTaiXe, PhuongTien.BienSoXe, LichTrinhVanHanh.NgayGioBatDau, LichTrinhVanHanh.NgayGioKetThuc
FROM LichTrinhVanHanh
JOIN KhachHang ON LichTrinhVanHanh.KhachHangID = KhachHang.KhachHangID
JOIN TaiXe ON LichTrinhVanHanh.TaiXeID = TaiXe.TaiXeID
JOIN PhuongTien ON LichTrinhVanHanh.PhuongTienID = PhuongTien.PhuongTienID;
--bảo trì theo phương tiện
CREATE VIEW ViewBaoTriTheoPhuongTien AS
SELECT PhuongTien.BienSoXe, LichSuBaoTri.MoTa, LichSuBaoTri.NgayBaoTri
FROM LichSuBaoTri
JOIN PhuongTien ON LichSuBaoTri.PhuongTienID = PhuongTien.PhuongTienID;

--In ra view
SELECT * FROM ViewKhachHang;
--
SELECT * FROM ViewTaiXe;
--
SELECT * FROM ViewLichTrinhVanHanh;
--
SELECT * FROM ViewPhuongTien;
--
SELECT * FROM ViewLichSuBaoTri;
--
SELECT * FROM ViewTongHopLichTrinhTheoTaiXe;
--
SELECT * FROM ViewTongHopBaoTriTheoPhuongTien;
--
SELECT * FROM ViewLichTrinhTheoKhachHang;
--
SELECT * FROM ViewChiTietLichTrinh;
--
SELECT * FROM ViewBaoTriTheoPhuongTien;








-- Xóa dữ liệu cũ trước khi chèn dữ liệu mới
DELETE FROM LichSuBaoTri;
DELETE FROM LichTrinhVanHanh;
DELETE FROM PhuongTien;
DELETE FROM TaiXe;
DELETE FROM KhachHang;

-- Chèn dữ liệu vào bảng KhachHang
INSERT INTO KhachHang (KhachHangID, Ten, DiaChi, SoDienThoai) 
VALUES 
(1, N'Trần Đình Nam', N'Hà Nam', '0901234567'),
(2, N'Hà Phi Hùng', N'Hưng Yên', '0912345678'),
(3, N'Hoàng Đình Nam', N'Hà Nội', '0923456789'),
(4, N'Nguyễn Văn A', N'Đà Nẵng', '0934567890'),
(5, N'Nguyễn Thị B', N'Hà Tĩnh', '0945678901'),
(6, N'Phạm Văn C', N'Nam Định', '0956789012'),
(7, N'Trần Văn D', N'Thái Bình', '0967890123'),
(8, N'Đỗ Minh E', N'TPHCM', '0978901234'),
(9, N'Nguyễn Văn F', N'Hà Giang', '0989012345'),
(10, N'Lê Thị G', N'Vĩnh Long', '0990123456'),
(11, N'Hồ Văn H', N'Kiên Giang', '0902345678'),
(12, N'Tô Văn I', N'Quảng Nam', '0913456789'),
(13, N'Nguyễn Văn J', N'Quảng Ngãi', '0924567890'),
(14, N'Vũ Thị K', N'THCM', '0935678901'),
(15, N'Nguyễn Thị L', N'Thừa Thiên Huế', '0946789012');
GO
SELECT * FROM KhachHang;

-- Chèn dữ liệu vào bảng TaiXe
INSERT INTO TaiXe (TaiXeID, Ten, SoDienThoai) 
VALUES 
(1, N'Trần Đình Nam', '0934567890'),
(2, N'Hà Phi Hùng', '0945678901'),
(3, N'Lươn Đình Nam', '0956789012'),
(4, N'Nguyễn Văn A', '0966789012'),
(5, N'Phạm Văn B', '0977890123'),
(6, N'Tô Văn C', '0988901234'),
(7, N'Nguyễn Thị D', '0999012345'),
(8, N'Vũ Văn E', '0900123456'),
(9, N'Hồ Thị F', '0911234567'),
(10, N'Đỗ Văn G', '0922345678'),
(11, N'Nguyễn Văn H', '0933456789'),
(12, N'Lê Thị I', '0944567890'),
(13, N'Hoàng Văn J', '0955678901'),
(14, N'Nguyễn Văn K', '0966789012'),
(15, N'Trần Thị L', '0977890123');
GO
SELECT * FROM TaiXe;

-- Chèn dữ liệu vào bảng PhuongTien
INSERT INTO PhuongTien (PhuongTienID, LoaiPhuongTien, BienSoXe) 
VALUES 
(1, N'Xe tải', N'29A-12345'),
(2, N'Xe container', N'29B-99999'),
(3, N'Xe khách', N'29C-56789'),
(4, N'Xe limousine', N'29D-11111'),
(5, N'Xe máy', N'29E-22222'),
(6, N'Xe ô tô con', N'29F-33333'),
(7, N'Xe buýt', N'29G-44444'),
(8, N'Xe tải nhỏ', N'29H-55555'),
(9, N'Xe kéo', N'29I-66666'),
(10, N'Xe ba gác', N'29J-77777'),
(11, N'Xe nâng', N'29K-88888'),
(12, N'Xe cứu hỏa', N'29L-99900'),
(13, N'Xe cứu thương', N'29M-00011'),
(14, N'Xe điện', N'29N-12332'),
(15, N'Xe thể thao', N'29O-45654');
GO
SELECT * FROM PhuongTien;

-- Chèn dữ liệu vào bảng LichTrinhVanHanh
INSERT INTO LichTrinhVanHanh (LichTrinhID, KhachHangID, TaiXeID, PhuongTienID, NgayGioBatDau, NgayGioKetThuc) 
VALUES 
(1, 1, 1, 1, '2024-11-20 08:00:00', '2024-11-20 10:00:00'),
(2, 2, 2, 2, '2024-11-21 09:00:00', '2024-11-21 12:00:00'),
(3, 3, 3, 3, '2024-11-22 07:30:00', '2024-11-22 09:30:00'),
(4, 1, 2, 1, '2024-11-23 10:00:00', '2024-11-23 12:00:00'),
(5, 2, 3, 2, '2024-11-24 11:00:00', '2024-11-24 14:00:00'),
(6, 3, 1, 3, '2024-11-25 06:00:00', '2024-11-25 08:00:00'),
(7, 1, 1, 2, '2024-11-26 13:00:00', '2024-11-26 15:00:00'),
(8, 2, 2, 1, '2024-11-27 14:30:00', '2024-11-27 16:30:00'),
(9, 3, 3, 2, '2024-11-28 15:00:00', '2024-11-28 17:00:00'),
(10, 1, 2, 3, '2024-11-29 09:00:00', '2024-11-29 11:00:00'),
(11, 2, 1, 1, '2024-11-30 12:00:00', '2024-11-30 14:00:00'),
(12, 3, 2, 2, '2024-12-01 10:30:00', '2024-12-01 12:30:00'),
(13, 1, 3, 3, '2024-12-02 07:00:00', '2024-12-02 09:00:00'),
(14, 2, 1, 1, '2024-12-03 11:00:00', '2024-12-03 13:00:00'),
(15, 3, 2, 2, '2024-12-04 16:00:00', '2024-12-04 18:00:00');
GO
SELECT * FROM LichTrinhVanHanh;

-- Chèn dữ liệu vào bảng LichSuBaoTri
INSERT INTO LichSuBaoTri (BaoTriID, PhuongTienID, MoTa, NgayBaoTri)
VALUES 
(1, 1, N'Thay dầu động cơ', '2024-10-15 14:00:00'),
(2, 2, N'Kiểm tra hệ thống phanh', '2024-11-01 10:30:00'),
(3, 3, N'Thay lốp xe', '2024-11-05 08:00:00'),
(4, 1, N'Bảo trì định kỳ', '2024-11-10 09:00:00'),
(5, 2, N'Sửa chữa hệ thống điện', '2024-11-12 13:30:00'),
(6, 3, N'Vệ sinh bên ngoài', '2024-11-15 11:00:00'),
(7, 1, N'Kiểm tra mức nước làm mát', '2024-11-18 15:00:00'),
(8, 2, N'Thay lọc gió', '2024-11-20 16:30:00'),
(9, 3, N'Kiểm tra phanh', '2024-11-22 10:00:00'),
(10, 1, N'Thay ắc quy', '2024-11-25 14:00:00'),
(11, 2, N'Định vị GPS', '2024-11-27 12:00:00'),
(12, 3, N'Thay đèn pha', '2024-11-29 09:30:00'),
(13, 1, N'Kiểm tra lốp', '2024-12-01 11:15:00'),
(14, 2, N'Kiểm tra hệ thống treo', '2024-12-03 08:45:00'),
(15, 3, N'Thay dầu hộp số', '2024-12-05 10:30:00');
GO
SELECT * FROM LichSuBaoTri;

-- Truy vấn kiểm tra
SELECT * FROM KhachHang;
SELECT * FROM TaiXe;
SELECT * FROM PhuongTien;
SELECT * FROM LichTrinhVanHanh;
SELECT * FROM LichSuBaoTri;
GO

--Tạo Trigger 
		--1.  Trigger ghi lại thêm khách hàng

CREATE TRIGGER trg_AfterInsertKhachHang
ON KhachHang
AFTER INSERT
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('KhachHang', 'Thêm', GETDATE());
END;

		--2. Trigger ghi lại lịch sử thay đổi thông tin khách hàng

		CREATE TRIGGER trg_AfterUpdateKhachHang
		ON KhachHang
		AFTER UPDATE
		AS
		BEGIN
			INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
			VALUES ('KhachHang', 'Cập nhật', GETDATE());
		END;

		--3. Trigger ghi lại xóa tài xế

CREATE TRIGGER trg_AfterDeleteTaiXe
ON TaiXe
AFTER DELETE
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('TaiXe', 'Xóa', GETDATE());
END;
		--4. Trigger ghi lại lịch sử thay đổi thông tin tài xế

		CREATE TRIGGER trg_AfterUpdateTaiXe
		ON TaiXe
		AFTER UPDATE
		AS
		BEGIN
			INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
			VALUES ('TaiXe', 'Cập nhật', GETDATE());
		END;
		--5. Trigger ghi lại thêm tài xế

CREATE TRIGGER trg_AfterInsertTaiXe
ON TaiXe
AFTER INSERT
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('TaiXe', 'Thêm', GETDATE());
END;
		--6. Trigger ghi lại lịch sử thay đổi thông tin phương tiện

		CREATE TRIGGER trg_AfterUpdatePhuongTien
		ON PhuongTien
		AFTER UPDATE
		AS
		BEGIN
			INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
			VALUES ('PhuongTien', 'Cập nhật', GETDATE());
		END;
		--7. Trigger ghi lại lịch sử thêm lịch trình vận hành

		CREATE TRIGGER trg_AfterInsertLichTrinh
		ON LichTrinhVanHanh
		AFTER INSERT
		AS
		BEGIN
			INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
			VALUES ('LichTrinhVanHanh', 'Thêm', GETDATE());
		END;
		--8. Trigger ghi lại lịch sử thay đổi lịch trình vận hành

		CREATE TRIGGER trg_AfterUpdateLichTrinh
		ON LichTrinhVanHanh
		AFTER UPDATE
		AS
		BEGIN
			INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
			VALUES ('LichTrinhVanHanh', 'Cập nhật', GETDATE());
		END;
		--9. Trigger ghi lại lịch sử xóa lịch trình vận hành

		CREATE TRIGGER trg_AfterDeleteLichTrinh
		ON LichTrinhVanHanh
		AFTER DELETE
		AS
		BEGIN
			INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
			VALUES ('LichTrinhVanHanh', 'Xóa', GETDATE());
		END;
		--10. Trigger ghi lại lịch sử thêm bảo trì

		CREATE TRIGGER trg_AfterInsertBaoTri
		ON LichSuBaoTri
		AFTER INSERT
		AS
		BEGIN
			INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
			VALUES ('LichSuBaoTri', 'Thêm', GETDATE());
		END;



-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_CheckSoDienThoaiKhachHang', 'TR') IS NOT NULL
DROP TRIGGER trg_CheckSoDienThoaiKhachHang;
GO

CREATE TRIGGER trg_CheckSoDienThoaiKhachHang
ON KhachHang
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM KhachHang WHERE SoDienThoai IN (SELECT SoDienThoai FROM inserted))
    BEGIN
        RAISERROR('Số điện thoại đã tồn tại!', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO KhachHang (KhachHangID, Ten, DiaChi, SoDienThoai)
        SELECT KhachHangID, Ten, DiaChi, SoDienThoai FROM inserted;
    END
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_AfterUpdateKhachHang', 'TR') IS NOT NULL
DROP TRIGGER trg_AfterUpdateKhachHang;
GO

CREATE TRIGGER trg_AfterUpdateKhachHang
ON KhachHang
AFTER UPDATE
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('KhachHang', 'Cập nhật', GETDATE());
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_CheckSoDienThoaiTaiXe', 'TR') IS NOT NULL
DROP TRIGGER trg_CheckSoDienThoaiTaiXe;
GO

CREATE TRIGGER trg_CheckSoDienThoaiTaiXe
ON TaiXe
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM TaiXe WHERE SoDienThoai IN (SELECT SoDienThoai FROM inserted))
    BEGIN
        RAISERROR('Số điện thoại tài xế đã tồn tại!', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO TaiXe (TaiXeID, Ten, SoDienThoai)
        SELECT TaiXeID, Ten, SoDienThoai FROM inserted;
    END
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_AfterUpdateTaiXe', 'TR') IS NOT NULL
DROP TRIGGER trg_AfterUpdateTaiXe;
GO

CREATE TRIGGER trg_AfterUpdateTaiXe
ON TaiXe
AFTER UPDATE
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('TaiXe', 'Cập nhật', GETDATE());
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_CheckBienSoXe', 'TR') IS NOT NULL
DROP TRIGGER trg_CheckBienSoXe;
GO

CREATE TRIGGER trg_CheckBienSoXe
ON PhuongTien
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM PhuongTien WHERE BienSoXe IN (SELECT BienSoXe FROM inserted))
    BEGIN
        RAISERROR('Biển số xe đã tồn tại!', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO PhuongTien (PhuongTienID, LoaiPhuongTien, BienSoXe)
        SELECT PhuongTienID, LoaiPhuongTien, BienSoXe FROM inserted;
    END
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_AfterUpdatePhuongTien', 'TR') IS NOT NULL
DROP TRIGGER trg_AfterUpdatePhuongTien;
GO

CREATE TRIGGER trg_AfterUpdatePhuongTien
ON PhuongTien
AFTER UPDATE
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('PhuongTien', 'Cập nhật', GETDATE());
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_AfterInsertLichTrinh', 'TR') IS NOT NULL
DROP TRIGGER trg_AfterInsertLichTrinh;
GO

CREATE TRIGGER trg_AfterInsertLichTrinh
ON LichTrinhVanHanh
AFTER INSERT
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('LichTrinhVanHanh', 'Thêm', GETDATE());
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_AfterUpdateLichTrinh', 'TR') IS NOT NULL
DROP TRIGGER trg_AfterUpdateLichTrinh;
GO

CREATE TRIGGER trg_AfterUpdateLichTrinh
ON LichTrinhVanHanh
AFTER UPDATE
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('LichTrinhVanHanh', 'Cập nhật', GETDATE());
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_AfterDeleteLichTrinh', 'TR') IS NOT NULL
DROP TRIGGER trg_AfterDeleteLichTrinh;
GO

CREATE TRIGGER trg_AfterDeleteLichTrinh
ON LichTrinhVanHanh
AFTER DELETE
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('LichTrinhVanHanh', 'Xóa', GETDATE());
END;
GO

-- Xóa trigger nếu tồn tại
IF OBJECT_ID('trg_AfterInsertBaoTri', 'TR') IS NOT NULL
DROP TRIGGER trg_AfterInsertBaoTri;
GO

CREATE TRIGGER trg_AfterInsertBaoTri
ON LichSuBaoTri
AFTER INSERT
AS
BEGIN
    INSERT INTO LichSuThayDoi (TenBang, ThaoTac, ThoiGian)
    VALUES ('LichSuBaoTri', 'Thêm', GETDATE());
END;
GO

 --Xây dựng các procedure 

 --10.Procedure để thêm khách hàng

CREATE PROCEDURE AddKhachHang
    @KhachHangID INT,
    @Ten VARCHAR(50),
    @DiaChi VARCHAR(50),
    @SoDienThoai VARCHAR(50)
AS
BEGIN
    INSERT INTO KhachHang (KhachHangID, Ten, DiaChi, SoDienThoai)
    VALUES (@KhachHangID, @Ten, @DiaChi, @SoDienThoai);
END;

 --1.Procedure để cập nhật thông tin khách hàng

CREATE PROCEDURE UpdateKhachHang
    @KhachHangID INT,
    @Ten VARCHAR(50),
    @DiaChi VARCHAR(50),
    @SoDienThoai VARCHAR(50)
AS
BEGIN
    UPDATE KhachHang
    SET Ten = @Ten, DiaChi = @DiaChi, SoDienThoai = @SoDienThoai
    WHERE KhachHangID = @KhachHangID;
END;

--2.Procedure để xóa khách hàng

CREATE PROCEDURE DeleteKhachHang
    @KhachHangID INT
AS
BEGIN
    DELETE FROM KhachHang
    WHERE KhachHangID = @KhachHangID;
END;

--3.Procedure để thêm tài xế

CREATE PROCEDURE AddTaiXe
    @TaiXeID INT,
    @Ten VARCHAR(50),
    @SoDienThoai VARCHAR(50)
AS
BEGIN
    INSERT INTO TaiXe (TaiXeID, Ten, SoDienThoai)
    VALUES (@TaiXeID, @Ten, @SoDienThoai);
END;

--4.Procedure để cập nhật thông tin tài xế

CREATE PROCEDURE UpdateTaiXe
    @TaiXeID INT,
    @Ten VARCHAR(50),
    @SoDienThoai VARCHAR(50)
AS
BEGIN
    UPDATE TaiXe
    SET Ten = @Ten, SoDienThoai = @SoDienThoai
    WHERE TaiXeID = @TaiXeID;
END;

--5.Procedure để xóa tài xế

CREATE PROCEDURE DeleteTaiXe
    @TaiXeID INT
AS
BEGIN
    DELETE FROM TaiXe
    WHERE TaiXeID = @TaiXeID;
END;

--6.Procedure để thêm phương tiện

CREATE PROCEDURE AddPhuongTien
    @PhuongTienID INT,
    @LoaiPhuongTien VARCHAR(50),
    @BienSoXe VARCHAR(50)
AS
BEGIN
    INSERT INTO PhuongTien (PhuongTienID, LoaiPhuongTien, BienSoXe)
    VALUES (@PhuongTienID, @LoaiPhuongTien, @BienSoXe);
END;

--7. Procedure để cập nhật thông tin phương tiện

CREATE PROCEDURE UpdatePhuongTien
    @PhuongTienID INT,
    @LoaiPhuongTien VARCHAR(50),
    @BienSoXe VARCHAR(50)
AS
BEGIN
    UPDATE PhuongTien
    SET LoaiPhuongTien = @LoaiPhuongTien, BienSoXe = @BienSoXe
    WHERE PhuongTienID = @PhuongTienID;
END;

--8. Procedure để xóa phương tiện

CREATE PROCEDURE DeletePhuongTien
    @PhuongTienID INT
AS
BEGIN
    DELETE FROM PhuongTien
    WHERE PhuongTienID = @PhuongTienID;
END;

--9.Procedure để thêm lịch trình vận hành

CREATE PROCEDURE AddLichTrinhVanHanh
    @LichTrinhID INT,
    @KhachHangID INT,
    @TaiXeID INT,
    @PhuongTienID INT,
    @NgayGioBatDau DATETIME,
    @NgayGioKetThuc DATETIME
AS
BEGIN
    INSERT INTO LichTrinhVanHanh (LichTrinhID, KhachHangID, TaiXeID, PhuongTienID, NgayGioBatDau, NgayGioKetThuc)
    VALUES (@LichTrinhID, @KhachHangID, @TaiXeID, @PhuongTienID, @NgayGioBatDau, @NgayGioKetThuc);
END;
