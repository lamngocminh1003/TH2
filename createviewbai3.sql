--1 --
create view TH4bai3 as
SELECT Hangsx.mahangsx, Hangsx.tenhang, COUNT(Sanpham.masp) AS SoLoaiSanPham
FROM Hangsx
LEFT JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
GROUP BY Hangsx.mahangsx, Hangsx.tenhang;

--2 --
create view TH4bai32 as
SELECT masp, SUM(soluongN * dongiaN) AS TongTienNhap
FROM Nhap
WHERE YEAR(ngaynhap) = 2020
GROUP BY masp;

--3 --
create view TH4bai33 as
SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) AS tong_so_luong_xuat
FROM Sanpham JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE Sanpham.mahangsx = 'H01'
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;
--4 --
create view TH4bai34 as
SELECT phong, COUNT(*) as 'So_luong_nhan_vien_nam'
FROM Nhanvien
WHERE gioitinh = N'Nam'
GROUP BY phong;

--5 --
create view TH4bai35 as
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) AS tongnhap
FROM Hangsx
JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2020
GROUP BY Hangsx.tenhang
-- 6 --
create view TH4bai36 as
SELECT Nhanvien.manv, Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) AS tongtienxuat
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
INNER JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.manv, Nhanvien.tennv
-- 7 --
create view TH4bai37 as
SELECT manv, SUM(soluongN * dongiaN) AS tong_tien_nhap
FROM Nhap
WHERE MONTH(ngaynhap) = 8 AND YEAR(ngaynhap) = 2018
GROUP BY manv
HAVING SUM(soluongN * dongiaN) > 100000;
-- 8 --
create view TH4bai38 as
SELECT *
FROM Sanpham
WHERE masp NOT IN (SELECT masp FROM Xuat)
-- 9 --
create view TH4bai39 as
SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Nhap.ngaynhap, Xuat.ngayxuat
FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhap ON Sanpham.masp = Nhap.masp
JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Nhap.ngaynhap) = 2018 AND YEAR(Xuat.ngayxuat) = 2018;
-- 10 --
create view TH4bai310 as
SELECT DISTINCT NV.manv, NV.tennv
FROM Nhap N 
JOIN Xuat X ON N.masp = X.masp AND N.manv = X.manv
JOIN Nhanvien NV ON N.manv = NV.manv;
-- 11 --
create view TH4bai311 as
SELECT Nhanvien.*, Nhap.masp, Nhap.ngaynhap, Nhap.sohdn, Nhap.soluongN, Nhap.dongiaN,
Xuat.ngayxuat, Xuat.sohdx, Xuat.soluongX
FROM Nhanvien
LEFT JOIN Nhap ON Nhanvien.manv = Nhap.manv
LEFT JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Nhap.manv IS NULL AND Xuat.manv IS NULL;