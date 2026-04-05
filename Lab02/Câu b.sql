USE QLBongDa;
GO
-- 1: thống kê số lượng cầu thủ mỗi câu lạc bộ
SELECT clb.TENCLB, COUNT(ct.MACT) AS SOLUONG_CAUTHU
FROM CAULACBO clb
LEFT JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
GROUP BY clb.TENCLB 
GO

-- 2. Thống kê số lượng cầu thủ nước ngoài (có quốc tịch khác  Việt Nam) của mỗi câu lạc bộ
SELECT clb.TENCLB, COUNT(ct.MACT) AS CAUTHU_NUOCNGOAI
FROM CAULACBO clb
JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
WHERE ct.MAQG <> 'VN'
GROUP BY clb.TENCLB;
GO

-- 3.Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác Việt Nam) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài. 
SELECT clb.MACLB, clb.TENCLB, s.TENSAN, s.DIACHI, COUNT(ct.MACT) AS SO_LUONG_CTNN
FROM CAULACBO clb
JOIN SANVD s ON clb.MASAN = s.MASAN
JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
WHERE ct.MAQG <> 'VN'
GROUP BY clb.MACLB, clb.TENCLB, s.TENSAN, s.DIACHI
HAVING COUNT(ct.MACT) > 2;
GO

-- Câu 4: Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý.
SELECT t.TENTINH, COUNT(ct.MACT) AS SO_LUONG_TIEN_DAO
FROM TINH t
JOIN CAULACBO clb ON t.MATINH = clb.MATINH
JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
WHERE ct.VITRI = N'Tiền đạo'
GROUP BY t.TENTINH
GO

-- Câu 5: Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp hạng vòng 3, năm 2009.
SELECT TOP 1 clb.TENCLB, t.TENTINH
FROM CAULACBO clb
JOIN TINH t ON clb.MATINH = t.MATINH
JOIN BANGXH bxh ON clb.MACLB = bxh.MACLB
WHERE bxh.VONG = 3 AND bxh.NAM = 2009
ORDER BY bxh.HANG ASC;
GO

