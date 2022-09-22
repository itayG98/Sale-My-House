use master;

--drop DATABASE [Sale My House DB]; --If already exicts drop and recreate
create database [Sale My House DB]; --Creates the DB
use [Sale My House DB];

--Cities
create Table [Cities](
	[City ID]  int IDENTITY (1,1)  primary key ,
	Name varchar(15) not null,
	Region varchar(15) not null
				);

insert into Cities values
	('Rehovot','Mercaz'),
	('Tel Aviv','Mercaz'),
	('Rishon Letzion','Mercaz'),
	('Ramat Ishay','Galil Tachton'),
	('Sde Yoav','Darom'),
	('Ashkelon','Darom'),
	('Qiryat Shmona','Galil Elyon'),
	('Arad','Darom'),
	('Jerusalem','Jerusalem');

--Neigberhoods
create Table [Neigberhoods](
	[Neigberhood ID]  int IDENTITY (1,1)  primary key ,
	[City ID] int REFERENCES Cities([City ID]) not null,
	Name varchar(20) not null,
				);

insert into [Neigberhoods] values
	(2,'Yafe Nof'),
	(5,'Yafe Nof'),
	(1,'Yafe Nof'),
	(6,'Galil'),
	(1,'Rehovot Hachadasha'),
	(1,'Neve Shaanan'),
	(5,'Galil'),
	(3,'Rehovot Hachadasha'),
	(2,'Neve Shaanan');


--House Types
create Table [House Types] (
	[House Type ID]  int IDENTITY(1,1)  primary key ,
	[Type Name] varchar(20) not null UNIQUE,
				);

insert into [House Types] values
	('Farmhouse'),
	('Multy-Family'),
	('Single-Family'),
	('Shared Apartment'),
	('Villa'),
	('Apartment'),
	('Penthouse');

--Companies
create Table [Companies](
	[Company ID]  int IDENTITY(1,1)  primary key ,
	[Company Name]  varchar(20) not null UNIQUE,
	[office number] varchar(10) not null UNIQUE,
	Neigberhood int  REFERENCES [Neigberhoods]([Neigberhood ID]) not null,
	Address varchar (25) not null,
				);

--Sales Men
create Table [Sales Men](
	[Sales Man ID]  int IDENTITY(100,2)  primary key ,
	[Company ID] int REFERENCES [Companies]([Company ID]) not null,
	[First Name] varchar (15) not null,
	[Last Name] varchar (15) not null,
	[Phone Number] varchar(10) not null,
	Neigberhood int  REFERENCES [Neigberhoods]([Neigberhood ID]) not null,
	Address varchar (25) not null,
	unique ([phone number])
				);

--Add manager field to Companies table
alter table [Companies]
	add [Manager Id] int  
alter table [Companies]
	add constraint  [Manager Id] foreign key ([Manager Id]) references [Sales Men]([Sales Man ID]);

insert into [Companies]
	([Company Name],[office number],Neigberhood,Address)
	values
	('Home Sweet Home','0544345678',2,'Moskovih 14');

insert into [Sales Men] values
	(1,'Avri','Jonas','0544345678',2,'Herzel 14'),
	(1,'Shon','Gilad','0144340000',1,'Shomria 14'),
	(1,'Avri','Israel','1144345111',3,'Even Gvriol 14'),
	(1,'Israeli','Jonas','0534345222',2,'Ron shmuel 14'),
	(1,'Avri','Israel','0543345678',2,'Irusim 18'),
	(1,'Avri','Oz','0544540000',1,'Moskovih 11'),
	(1,'Avri','Catz','0544365111',3,'Irusim 14'),
	(1,'David','Ariel','0544347222',6,'Moskovih 14'),
	(1,'Itay','Lev','0544345878',2,'Irusim 14'),
	(1,'Shir','Alex','0544341100',1,'Even Gvriol 14'),
	(1,'Maya','Jonas','0544342211',3,'Moskovih 14'),
	(1,'Or','Jonas','0544341111',6,'Irusim 14'),
	(1,'Maria','Jonas','0544345622',2,'Even Gvriol 1'),
	(1,'Jhonathan','Jonas','0544340022',1,'Irusim 1'),
	(1,'Barak','Obama','0544345123',3,'Herzel 13'),
	(1,'Asi','Miriam','0544312345',6,'Herzel 44');

--Insert first manager to the table
UPDATE Companies
	SET [Manager Id] = 100
	WHERE [Company ID]  = 1;

--Add not null to managers field in companies table
alter table [Companies]
	alter column  [Manager Id] 
	int not null

--Specialization
create Table [Specialization](
	[Sales Man ID]  int REFERENCES [Sales men]([Sales Man ID] ) not null,
	[Specialization] int  REFERENCES [House Types]([House Type ID]) not null,
	PRIMARY KEY ([Sales Man ID],[Specialization]) ,
	UNIQUE ([Sales Man ID],[Specialization]) 
				);

insert into [Specialization] ([Sales Man ID],[Specialization]) values 
	(100,1),
	(100,2),
	(100,3),
	(100,4),
	(102,1),
	(104,1),
	(106,2),
	(106,1),
	(110,4),
	(112,1),
	(112,2),
	(112,3),
	(112,4),
	(114,1),
	(116,2),
	(116,3),
	(118,1),
	(120,2),
	(122,2),
	(122,1);

--Customers
create Table Customers(
	[Customer ID]  int IDENTITY(101,2)  primary key ,
	[Company ID] int REFERENCES [Companies]([Company ID]) not null,
	[First Name] varchar (15) not null,
	[Last Name] varchar (15) not null,
	[Phone Number] varchar(10) not null,
	Neigberhood int  REFERENCES [Neigberhoods]([Neigberhood ID]) not null,
	Address varchar (25) not null,
	unique ([phone number])
				);

insert into Customers values
	(1,'Shay','Madmon','0542225678',2,'Erez 41'),
	(1,'John','Hagiladi','0156340000',1,'Gavriel 4'),
	(1,'Avi','Alon','1144199111',3,'Even Gvriol 41'),
	(1,'koby','Jonas','053432222',2,'Ron shmuel 11'),
	(1,'Ariel','Israel','0543105678',2,'Irusim 1'),
	(1,'Shoham','Israel','0544540100',1,'Erez 11'),
	(1,'Avri','Bar','0544365119',3,'Irusim 1'),
	(1,'David','Rogovsky','0544327222',6,'Erez 11'),
	(1,'Itay','Kim','0544341878',2,'Gavriel 1'),
	(1,'Shir','Shomer','0574341100',1,'Even Gvriol 4'),
	(1,'May','Har Lev','0537342211',3,'Moskovih 4'),
	(1,'Or','Eyal','0544341011',6,'Gavriel 1'),
	(1,'Shir','Joseph','0544555622',2,'Even Gvriol 16'),
	(1,'Kim','Yucht','0544343628',1,'Gavriel 16'),
	(1,'Obama','Trump','0544345103',3,'Herzel 3'),
	(1,'Simon','Levayev','0544712345',6,'Gavriel 4');

--Houses
create Table [Houses](
	[House ID]   int IDENTITY(1,1)  primary key ,
	[House Type] int REFERENCES [House Types]([House Type ID]) not null,
	[Neigberhood] int  REFERENCES [Neigberhoods]([Neigberhood ID]) not null,
	[Owner ID] int  REFERENCES Customers([Customer ID]) not null,
	Address varchar (25) not null,
	Size int not null,
	check (Size >0)
				);

insert into [Houses] values 
(1,1,103,'Lev yam 13',125),
(2,2,101,'Herzel 3',135),
(3,3,103,'Herzel 3',105),
(1,4,105,'Lev yam 12',115),
(1,5,103,'Even gvirol 1',200),
(2,2,103,'Haroee',170),
(1,2,101,'Los Angeles 1',120),
(4,2,103,'Japan 1',50),
(2,5,105,'Mitzpe Ramon 14',50),
(1,3,111,'Ben Gurion 12',85),
(2,1,113,'Ben Gurion 12',100),
(1,1,105,'Lev yam 12',96),
(3,4,109,'Ben Gurion 1',100),
(1,3,107,'Mitzpe Ramon 12',250),
(3,4,115,'Ben Gurion 2',100),
(3,4,117,'Ben Gurion 3',150),
(1,6,101,'Hashomer 10',170);

--Sales
create Table Sales(
	[Sale ID]  int IDENTITY(1,1)  primary key ,
	[House ID] int  REFERENCES [Houses]([House ID]) not null,
	[Seller ID] int  REFERENCES Customers([Customer ID]) not null,
	[Buyer ID] int  REFERENCES Customers([Customer ID]) ,
	[Sales Man ID] int  REFERENCES [Sales Men]([Sales Man ID]) ,
	[Requested price] int not null,
	[Final Price] int ,
	[Publish date] dateTime not null,
	[Purchesed date] dateTime,
	check (datediff (day,[Publish date],[Purchesed date])>0),
	check ([Buyer ID] != [Seller ID]),
	check ([Requested price] >0 and [Final Price] >0 ),
	check (
	([Buyer ID] !=null and [Final Price] !=null and [Purchesed date]!=null)
	or 
	([Buyer ID] =null and [Final Price] =null and [Purchesed date]=null))
				);

insert into [Sales] values
(1,101,113,102,1300000,1450000,'12-12-2016','10-10-2017'),
(1,113,111,102,1400000,1500000,'12-12-2018','10-10-2019'),
(1,111,103,118,1500000,1450000,'05-05-2019','12-12-2020'),
(2,113,111,120,1705000,1750000,'02-02-2018','10-10-2018'),
(2,111,101,106,1705000,1700000,'12-12-2021','01-01-2022'),
(3,107,109,122,1700000,1950000,'12-12-2021','02-15-2022'),
(3,109,103,122,1705000,1650000,'03-20-2021','05-15-2022'),
(4,105,null,122,1700000,null,'12-12-2021',null),
(5,103,null,114,1000000,null,'12-12-2021',null),
(6,111,103,112,1750000,1650000,'12-12-2019','01-01-2021'),
(6,103,null,112,1900000,null,'08-20-2022',null),
(7,101,null,100,2450000,null,'12-12-2021',null),
(8,103,null,110,3000000,null,'12-12-2021',null),
(9,117,105,112,1950000,3750000,'12-12-2021','01-01-2022'),
(10,111,null,112,3000000,null,'12-12-2020',null),
(11,111,113,116,1500000,1550000,'12-12-2020','01-14-2022'),
(12,105,null,106,1500000,null,'12-12-2020',null),
(13,105,109,112,900000,950000,'12-12-2020','05-07-2021'),
(14,115,107,104,1550000,1600000,'06-06-2021','11-09-2021'),
(14,107,null,112,1700000,null,'12-12-2021',null),
(15,107,115,112,3100000,3500000,'12-12-2018','03-07-2019'),
(15,101,117,100,3150000,3350000,'12-12-2019','03-01-2020'),
(17,101,null,100,3025000,null,'05-06-2020','07-22-2020');




--Queries :

--1 Revenue of the company from each house type yearly grouped

Select 
		[House Types].[House Type ID],
		[House Types].[Type Name] as 'House type',
		Sum(Sales.[Final Price]-Sales.[Requested price]) As 'Revenue',
		Year(Sales.[Purchesed date]) as 'Year'
from 
	Sales inner join Houses on Houses.[House ID] = Sales.[House ID]
	inner join [House Types] on Houses.[House Type]=[House Types].[House Type ID]
group by 
	[House Types].[Type Name],[House Types].[House Type ID],Year(Sales.[Purchesed date])
having 
	Sum(Sales.[Final Price]-Sales.[Requested price]) <> 0
order by 
	[House Types].[Type Name]

--2 Display custumers who sold house and bought more expensive house

go
Create View MinSold as 
Select 
	cust.[Customer ID],
	min(Sales.[Final Price]) as 'Min Sold'
from 
	Customers cust inner join Sales on Sales.[Seller ID]=Cust.[Customer ID]
where 
	Sales.[Final Price] <> 0
group by 
	[Customer ID]
go

go
Create View MaxBought as 
Select 
	cust.[Customer ID],
	Max(Sales.[Final Price]) as 'Max Bought'
from 
	Customers cust inner join Sales on Sales.[Buyer ID]=Cust.[Customer ID]
where 
	Sales.[Final Price] <>0
group by 
	[Customer ID]
go

go
Select 
	MaxBought.[Customer ID] as 'Bought much more expensive house' ,
	[Max Bought]-[Min Sold] as 'Price Diffrence'
from 
	MaxBought inner join MinSold on MaxBought.[Customer ID]=MinSold.[Customer ID]
where	
	MaxBought.[Max Bought]>MinSold.[Min Sold]
go

go
drop view MinSold
drop view MaxBought
go

--3 Display the average of each Neigberhood order by Most expensive

select 
	NGBD.[Name] as 'Neigberhood',
	Cities.Name as 'City',
	NGBD.[Neigberhood ID] ,
	avg(Sales.[Final Price]) as 'Average selling price' ,
	count(*) as 'Number of Sales'
from 
	Sales inner join Houses on Houses.[House ID]=Sales.[House ID]
	inner join Neigberhoods NGBD on   NGBD.[Neigberhood ID]=Houses.Neigberhood
	inner join Cities on  NGBD.[City ID] =Cities.[City ID] 
where	
	[Final Price] >0
group by 
	NGBD.[Name],NGBD.[Neigberhood ID],Cities.Name
order by 
	[Average selling price] desc

----4 Display the best employee by revenue for each year 
go
create View  YealryRevenueOfEmp as --YROE
(select	SM.[Sales Man ID],
		 year (Sales.[Purchesed date]) as 'The Year' ,
		 sum (Sales.[Final Price]-Sales.[Requested price]) as 'Revenue'
from 	 [Sales Men] SM inner join Sales on Sales.[Sales Man ID] =SM.[Sales Man ID]
where Sales.[Final Price] <> 0
group by year (Sales.[Purchesed date]) ,
	     SM.[Sales Man ID])
go

go
create View Year_and_max as 
(select  YROE.[The Year] as 'The Year' ,max(YROE.Revenue) as 'Maximum Revenue'
from YealryRevenueOfEmp YROE
group by YROE.[The Year])
go

go
select  Year_and_max.[The Year],
		YealryRevenueOfEmp.[Sales Man ID],
		max(Year_and_max.[Maximum Revenue]) as 'Maximum Revenue'

from Year_and_max left join YealryRevenueOfEmp on YealryRevenueOfEmp.[The Year] = Year_and_max.[The Year]
where YealryRevenueOfEmp.Revenue = Year_and_max.[Maximum Revenue]
group by Year_and_max.[The Year],YealryRevenueOfEmp.[Sales Man ID]
order by Year_and_max.[The Year]
go

go
drop view Year_and_max
go
go
drop view YealryRevenueOfEmp
go

----5 Offer a bigger house to a custumer which bought a house from 2 years ago and farther in the same city
go
create view NotRecentlyBought as
(	select 
		Customers.[Customer ID],
		max(Sales.[Purchesed date]) as 'Last Sale',
		Houses.[House ID]
	from Sales inner join Customers on Customers.[Customer ID]=Sales.[Buyer ID]
		inner join Houses on Sales.[House ID]=Houses.[House ID]
	group by Customers.[Customer ID],Houses.[House ID]
	having datediff (day,max(Sales.[Purchesed date]),getdate())>2*365
)
go

go
create view AvilabeHouses as
(	select Houses.[House ID],Houses.[Owner ID]
	from Houses inner join Sales on Sales.[House ID]=Houses.[House ID]
	where Sales.[Purchesed date] is null
)
go

go
select NotRecentlyBought.[Customer ID],
		AvilabeHouses.[House ID] as 'Offerd house',
		AvilabeHouses.[Owner ID] as 'Current owner of house',
		PrevHous.[House ID] 'Previously boght',
		avil.Size as 'Offerd Size',
		PrevHous.Size 'Previous size',
		Cities.[Name] as 'City',
		avilN.[Name] as 'Neigberhood'
from 
		AvilabeHouses inner join NotRecentlyBought on AvilabeHouses.[Owner ID]!=NotRecentlyBought.[Customer ID]
	   inner join  Houses avil  on avil.[House ID]=AvilabeHouses.[House ID]
	   inner join Houses PrevHous on PrevHous.[House ID]=NotRecentlyBought.[House ID]
	   inner join Neigberhoods avilN on avilN.[Neigberhood ID]=avil.Neigberhood
	   inner join Neigberhoods PrevN on PrevN.[Neigberhood ID]=PrevHous.Neigberhood
	   inner join Cities on avilN.[City ID]=Cities.[City ID]
where 
		PrevHous.Size<avil.Size and 
		PrevN.[City ID]=avilN.[City ID]
group by 
		NotRecentlyBought.[Customer ID],
		AvilabeHouses.[Owner ID],
		AvilabeHouses.[House ID],
		PrevHous.Size,PrevHous.[House ID],
		avil.Size,Cities.[Name],
		avilN.[Name]
order by 
		NotRecentlyBought.[Customer ID]
go

go
drop view NotRecentlyBought
drop view AvilabeHouses
go
