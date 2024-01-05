create table sinhvien(
	masv int primary key,
	hoten varchar(40),
	namsinh smallint,
	quequan varchar(40),
	diemtb dec(5,2)
)


insert into sinhvien values
(1,'tran van minh quoc',2004,'chuong my',6.9),
(2,'le trung kien',2004,'xuan mai',9.5),
(3,'nghiem xuan nam',2008,'chuong my',6.5),
(4,'nguyen viet anh',2008,'chuong my',7.0),
(5,'fifa online',2018,'ha noi',9.9),
(6,'ronaldo',1985,'bo dao nha',10.0),
(8,'minh quoc',2004,'chuong my',9.6)
create table detai(
	madt int primary key,
	tendt varchar(40),
	chunhiem varchar(40),
	kinhphi int
);
insert into detai values
(8,'bat dong san','minh quoc',1650000),
(7,'bong da','messi',5*power(10,6)),
(6,'bong da','cr7',power(10,6)),
(1,'fifa online','binh be',100000),
(2,'valorant','cmcxiceq',900000),
(3,'roblox','nicoteen2vien',500000),
(4,'truy kich','khovenucuoi',400000),
(5,'csgo','mqt',250000)
update detai set kinhphi = 5000000 where madt=8
select * from detai
create table "sv-dt"(
	masv int,
	madt int,
	noitt varchar(20),
	km smallint,
	ketqua varchar(20),
	primary key(masv,madt),
	foreign key (masv) references sinhvien(masv),
	foreign key (madt) references detai(madt)
);
insert into "sv-dt" values
(6,6,'a rap xe ut',1000,'dat'),
(1,1,'ha noi',30,'dat'),
(2,2,'ho chi minh',100,'dat'),
(3,3,'da nang',70,'ko dat'),
(4,4,'nghe an',300,'dat'),
(5,5,'ha tinh',150,'ko dat'),
(8,8,'xuan mai',7,'dat')
select * from "sv-dt"



--cách quê trên 100km và sinh trước năm 93
select * from sinhvien sv 
join "sv-dt" svdt on sv.masv=svdt.masv
where namsinh <1993 and svdt.km>100

--các đề tài có sinh viên thực tập
select dt.madt,tendt,chunhiem,kinhphi from detai dt 
join "sv-dt" svdt on svdt.madt=dt.madt
join sinhvien sv on sv.masv = svdt.masv

--danh sách sinh viên thực tập theo đề tài có kinh phí lớn hơn 1/5 tổng kinh phí cấp cho đề tài
--cách 1
select sv.masv,hoten,namsinh,quequan,diemtb from sinhvien sv
join "sv-dt" svdt on svdt.masv=sv.masv
join detai dt on dt.madt=svdt.madt
where kinhphi > (select sum(kinhphi)/5 from detai)
--cách 2
WITH tong AS (
    SELECT SUM(kinhphi)/5 AS total
    FROM detai
)
SELECT sv.masv, hoten, namsinh, quequan, diemtb 
FROM sinhvien sv
JOIN "sv-dt" svdt ON svdt.masv = sv.masv
JOIN detai dt ON dt.madt = svdt.madt, tong
WHERE dt.kinhphi > tong.total
--cách 3
SELECT sv.masv, hoten, namsinh, quequan, diemtb 
FROM sinhvien sv
JOIN "sv-dt" svdt ON svdt.masv = sv.masv
JOIN detai dt ON dt.madt = svdt.madt
CROSS JOIN (SELECT SUM(kinhphi)/5 AS total FROM detai) subquery
WHERE detai.kinhphi > subquery.total


--đề 10
create TABLE sach(
	masach smallint primary key,
	tensach varchar(40),
	nxb varchar(20)
);
insert into sach values
(1,'toan','giao duc'),
(2,'ngu van','giao duc'),
(3,'ngoai ngu','bach khoa'),
(4,'vat ly','kim dong'),
(5,'hoa hoc','giao duc'),
(6,'bi an ozone','kim dong');

create TABLE doc_gia(
	sothe SMALLINT PRIMARY KEY,
	hoten VARCHAR(40),
	diachi varchar(40),
	dienthoai varchar(20)
);
INSERT INTO doc_gia VALUES
(1,'tran van minh quoc','ha noi','0971864626'),
(2,'le trung kien','xuan mai','0982638947'),
(3,'nghiem xuan nam','thanh binh','0982645627'),
(4,'nguyen viet anh','thanh ne','0982746277'),
(5,'minh quoc tran','ha noi','0981242072');

CREATE TABLE muon_sach(
	masach SMALLINT,
	sothe SMALLINT,
	ngaymuon date,
	ngaytra date,
	PRIMARY KEY(masach,sothe),
	foreign key (masach) REFERENCES sach(masach),
	Foreign Key (sothe) REFERENCES doc_gia(sothe)
);
insert into muon_sach values
(1,1,'2020-2-1','2020-3-20'),
(2,2,'2020-12-21','2021-1-1'),
(3,3,'2020-3-3','2020-4-4'),
(4,4,'2020-5-5','2020-6-6'),
(5,5,'2020-7-7','2020-8-8');

--tên và địa chỉ của độc giả mượn vào ngày 1-2-2020 và trả vào 20-3-2020
SELECT hoten,diachi FROM doc_gia dg
join muon_sach ms on ms.sothe=dg.sothe
where ngaymuon = '2020-2-1' and ngaytra = '2020-3-20'

--số lần mượn sách của các độc giả có địa chỉ ở Hà Nội
select diachi, count(diachi) as so_lan_muon from doc_gia
group by diachi
having diachi='ha noi'

--sách chưa đc mượn bởi độc giả nào
select * from sach 
where masach not in (select masach from muon_sach)






