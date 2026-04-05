/*
	Bài thực hành số 2
*/
USE QLBongDa
GO


-- Câu 1 Cho biết thông tin (mã cầu thủ, họ tên, số áo, vị trí, ngày sinh, địa chỉ) của tất cả các cầu thủ
SELECT MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI
FROM CAUTHU;
GO

-- Câu 2: Hiển thị thông tin tất cả các cầu thủ có số áo là 7 chơi ở vị trí Tiền vệ. 
SELECT * FROM CAUTHU
WHERE SO = 7 AND VITRI = N'Tiền vệ';
GO
-- 3. Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cả các huấn luyện viên
SELECT TENHLV, NGAYSINH, DIACHI, DIENTHOAI
FROM HUANLUYENVIEN;
GO

-- 4. Hiển thi thông tin tất cả các cầu thủ có quốc tịch Việt Nam thuộc câu lạc bộ Becamex Bình Dương
SELECT ct.* FROM CAUTHU ct
JOIN CAULACBO clb ON ct.MACLB = clb.MACLB
WHERE clb.TENCLB = N'BECAMEX Bình Dương' AND ct.MAQG = 'VN'
GO

-- Câu 5: Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng 'SHB Đà Nẵng'.
SELECT ct.MACT, ct.HOTEN, ct.NGAYSINH, ct.DIACHI, ct.VITRI 
FROM CAUTHU ct
JOIN CAULACBO clb ON ct.MACLB = clb.MACLB
WHERE clb.TENCLB = N'SHB ĐÀ NẴNG';
GO

-- Câu 6: Hiển thị thông tin tất cả các cầu thủ đang thi đấu trong câu lạc bộ có sân nhà là "Long An".
SELECT ct.* FROM CAUTHU ct
JOIN CAULACBO clb ON ct.MACLB = clb.MACLB
JOIN SANVD s ON clb.MASAN = s.MASAN
WHERE s.TENSAN = N'Long An';
GO

-- Câu 7: Cho biết kết quả các trận đấu vòng 2 của mùa bóng năm 2009.
SELECT td.MATRAN, td.NGAYTD, s.TENSAN, clb1.TENCLB AS TENCLB1, clb2.TENCLB AS TENCLB2, td.KETQUA
FROM TRANDAU td
JOIN SANVD s ON td.MASAN = s.MASAN
JOIN CAULACBO clb1 ON td.MACLB1 = clb1.MACLB
JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE td.VONG = 2 AND td.NAM = 2009;
GO

-- Câu 8: Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB của các HLV có quốc tịch “Việt Nam”.
SELECT hlv.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, hc.VAITRO, clb.TENCLB
FROM HUANLUYENVIEN hlv
JOIN HLV_CLB hc ON hlv.MAHLV = hc.MAHLV
JOIN CAULACBO clb ON hc.MACLB = clb.MACLB
WHERE hlv.MAQG = 'VN';
GO

-- Câu 9: Lấy tên 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2009.
SELECT TOP 3 clb.TENCLB, bxh.DIEM
FROM CAULACBO clb
JOIN BANGXH bxh ON clb.MACLB = bxh.MACLB
WHERE bxh.VONG = 3 AND bxh.NAM = 2009
ORDER BY bxh.DIEM DESC;
GO

-- Câu 10: Cho biết mã HLV, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc mà CLB đó đóng ở Bình Dương.
SELECT hlv.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, hc.VAITRO, clb.TENCLB
FROM HUANLUYENVIEN hlv
JOIN HLV_CLB hc ON hlv.MAHLV = hc.MAHLV
JOIN CAULACBO clb ON hc.MACLB = clb.MACLB
JOIN TINH t ON clb.MATINH = t.MATINH
WHERE t.TENTINH = N'Bình Dương';
GO

