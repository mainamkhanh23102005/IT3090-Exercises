
USE QLBongDa;
GO

--a1
SELECT 
    td.NGAYTD, 
    clb1.TENCLB AS TENCLB1, 
    clb2.TENCLB AS TENCLB2, 
    td.KETQUA
FROM 
    TRANDAU td
    INNER JOIN CAULACBO clb1 ON td.MACLB1 = clb1.MACLB 
    INNER JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB 
WHERE 
    MONTH(td.NGAYTD) = 3 
    AND td.KETQUA LIKE '%-0'; -- Kết quả kết thúc bằng -0 (đội khách không ghi bàn)
-- a2
SELECT 
    MACT, HOTEN, NGAYSINH
FROM 
    CAUTHU
WHERE 
    HOTEN LIKE N'% Công %'; -- N để nhận diện tiếng Việt, dấu cách để tách biệt họ lót
--a3 Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ 'Nguyễn'
SELECT 
    MACT, HOTEN, NGAYSINH
FROM CAUTHU
WHERE 
    HOTEN NOT LIKE N'Nguyễn %';

-- a4 Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ của những huấn luyện viên Việt Nam có tuổi nằm trong khoảng 35-40
SELECT 
    MAHLV, TENHLV, NGAYSINH, DIACHI
FROM 
    HUANLUYENVIEN
WHERE 
    MAQG = 'VN'
    AND (YEAR(GETDATE()) - YEAR(NGAYSINH)) BETWEEN 35 AND 40;
-- a5 Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 8 năm 2019.
SELECT 
    clb.TENCLB
FROM 
    CAULACBO clb
    INNER JOIN HLV_CLB hc ON clb.MACLB = hc.MACLB
    INNER JOIN HUANLUYENVIEN hlv ON hc.MAHLV = hlv.MAHLV
WHERE 
    hc.VAITRO = N'HLV chính'
    AND DAY(hlv.NGAYSINH) = 20
    AND MONTH(hlv.NGAYSINH) = 8
    AND YEAR(hlv.NGAYSINH) = 2019;

-- a6 Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tính đến hết vòng 3 năm 2009
SELECT TOP 1
    clb.TENCLB,
    t.TENTINH
FROM 
    CAULACBO clb
    INNER JOIN TINH t ON clb.MATINH = t.MATINH
    INNER JOIN BANGXH bxh ON clb.MACLB = bxh.MACLB
WHERE 
    bxh.VONG = 3
    AND bxh.NAM = 2009
ORDER BY
    bxh.THANG = desc