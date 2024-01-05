create TABLE giangvien(
    magv SMALLINT PRIMARY KEY,
    hoten VARCHAR(40),
    diachi VARCHAR(40),
    ngaysinh DATE
);
INSERT INTO giangvien VALUES
(1,'tran van minh quoc','chuong my','2004-04-26'),
(2,'le trung kien','xuan mai','2004-12-21'),
(3,'nghiem xuan nam','thanh binh','2008-08-18'),
(4,'nguyen viet anh','thanh ne','2008-01-01'),
(5,'ronaldo','portugal','1985-05-02')
SELECT * FROM giangvien

CREATE TABLE detai(
    madt SMALLINT PRIMARY KEY,
    tendt VARCHAR(40),
    cap varchar(10),
    kinhphi int
)
INSERT INTO detai VALUES
(1,'phan loai van ban','co so',1000000),
(2,'dich tu dong anh viet','co so',5000000),
(3,'y te the thao','nganh',10000000),
(4,'viet vi ban tu dong','nganh',power(10,7)),
(5,'cong nghe var','nganh',5*power(10,6))
CREATE TABLE thamgia(
    magv SMALLINT,
    madt SMALLINT ,
    PRIMARY KEY(magv,madt),
    Foreign Key (magv) REFERENCES giangvien(magv),
    Foreign Key (madt) REFERENCES detai(madt),
    sogio SMALLINT
)
INSERT INTO thamgia VALUES
(1,1,100),
(2,2,200),
(3,3,300),
(4,4,400),
(5,5,500),
(1,4,690),
(2,5,210)

--giảng viên tham gia đề tài cụ thể
SELECT hoten,diachi,ngaysinh from thamgia tg
join giangvien gv on gv.magv=tg.magv
join detai dt on dt.madt = tg.madt 
where tendt in ('phan loai van ban','dich tu dong anh viet')


--giảng viên tham gia ít nhất 2 đề tài
SELECT tg.magv,gv.hoten,ngaysinh,diachi
FROM thamgia tg
join giangvien gv on gv.magv=tg.magv
GROUP BY tg.magv,gv.hoten,ngaysinh,diachi
HAVING COUNT(madt) >= 2;
-- đề tài tốn ít kinh phí nhất
SELECT * FROM detai
WHERE kinhphi = (SELECT MIN(kinhphi) from detai)