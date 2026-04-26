USE QLBongDa
GO
--b1: Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác "Việt Nam") tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài
SELECT
	clb.MACLB,
	clb.TENCLB,
	s.TENSAN,
	s.DIACHI,
	(SELECT COUNT(*)
	FROM CAUTHU ct
	WHERE ct.MACLB = clb.MACLB AND ct.MAQG <> 'VN') AS SoLuongNgoaiBinh
FROM 
	CAULACBO clb
	INNER JOIN SANVD s ON clb.MASAN = s.MASAN 
WHERE 
	(SELECT COUNT(*) 
	FROM CAUTHU ct 
	WHERE ct.MACLB = clb.MACLB AND ct.MAQG <> 'VN') > 2;

--b2 Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất năm 2009
SELECT 
	clb.TENCLB,
	t.TENTINH
FROM 
	CAULACBO clb 
	INNER JOIN TINH t ON clb.MATINH = t.MATINH
	INNER JOIN BANGXH bxh ON clb.MACLB = bxh.MACLB
WHERE 
	bxh.NAM = 2009
	AND bxh.HIEUSO = (SELECT MAX(HIEUSO) FROM BANGXH WHERE NAM = 2009); 