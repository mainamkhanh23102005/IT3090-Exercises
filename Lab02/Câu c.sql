-- Câu 1: Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong một câu lạc bộ mà chưa có số điện thoại.
SELECT TENHLV 
FROM HUANLUYENVIEN 
WHERE DIENTHOAI IS NULL OR DIENTHOAI = '';
GO

-- Câu 2: Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất kỳ một câu lạc bộ nào.
SELECT hlv.TENHLV
FROM HUANLUYENVIEN hlv
WHERE hlv.MAQG = 'VN' 
AND hlv.MAHLV NOT IN (SELECT MAHLV FROM HLV_CLB);
GO

-- Câu 3: Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2009 lớn hơn 6 hoặc nhỏ hơn 3.
SELECT ct.HOTEN, clb.TENCLB
FROM CAUTHU ct
JOIN CAULACBO clb ON ct.MACLB = clb.MACLB
JOIN BANGXH bxh ON clb.MACLB = bxh.MACLB
WHERE bxh.VONG = 3 AND bxh.NAM = 2009 AND (bxh.HANG > 6 OR bxh.HANG < 3);
GO

-- Câu 4: Cho biết danh sách các trận đấu của câu lạc bộ đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009.
SELECT td.NGAYTD, s.TENSAN, clb1.TENCLB AS TENCLB1, clb2.TENCLB AS TENCLB2, td.KETQUA
FROM TRANDAU td
JOIN SANVD s ON td.MASAN = s.MASAN
JOIN CAULACBO clb1 ON td.MACLB1 = clb1.MACLB
JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE td.MACLB1 = (SELECT TOP 1 MACLB FROM BANGXH WHERE VONG = 3 AND NAM = 2009 ORDER BY HANG ASC)
   OR td.MACLB2 = (SELECT TOP 1 MACLB FROM BANGXH WHERE VONG = 3 AND NAM = 2009 ORDER BY HANG ASC);
GO