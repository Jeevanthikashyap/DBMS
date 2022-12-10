create database bankdata;
use bankdata;
create table Branch
(
	Branch_name varchar(30),
    Branch_city varchar(20),
    Assets real,
	primary key(Branch_name)
);
create table Bank_account
(
	accno int,
    Branch_name varchar(30),
    Balance real,
    primary key(accno),
    foreign key(Branch_name) references Branch(Branch_name)
);
create  table Bank_customer
(
	Customer_name varchar(20),
    Customer_str varchar(30),
    city varchar(20),
    primary key(Customer_name)
);
create table Depositor
(
	Customer_name varchar(20),
    accno int,
    primary key(Customer_name,accno),
    foreign key(Customer_name) references Bank_customer(Customer_name),
    foreign key(accno) references Bank_account(accno)
);
create  table Loan
(
	loanno int,
    Branch_name varchar(30),
    amount real,
    primary key(loanno),
    foreign key(Branch_name) references Branch(Branch_name)
);
INSERT INTO Branch
values('SBI_Chamrajpet','Bangalore',50000),
		('SBI_ResidencyRoad','Bangalore',10000),
        ('SBI_ShivajiRoad','Bombay',20000),
        ('SBI_ParliamentRoad','Delhi',10000),
        ('SBI_Jantarmantar','Delhi',20000);
INSERT INTO Bank_account
values(1,'SBI_Chamrajpet',2000),
		(2,'SBI_ResidencyRoad',5000),
        (3,'SBI_ShivajiRoad',6000),
        (4,'SBI_ParliamentRoad',9000),
        (5,'SBI_Jantarmantar',8000),
		(6,'SBI_ShivajiRoad',4000),
        (8,'SBI_ResidencyRoad',4000),
		(9,'SBI_ParliamentRoad',3000),
        (10,'SBI_ResidencyRoad',5000),
		(11,'SBI_Jantarmantar',2000);
INSERT INTO Bank_customer
values('Avinash','Bull_Temple_Road','Bangalore'),
		('Dinesh','Bannergatta_Road','Bangalore'),
        ('Mohan','NationalCollege_Road','Bangalore'),
        ('Nikil','Akbar_Road','Delhi'),
        ('Ravi','Prithviraj_Road','Delhi');
insert into Depositor
values('Avinash',1),
		('Dinesh',2),
        ('Nikil',4),
        ('Ravi',5),
        ('Avinash',8),
        ('Nikil',9),
        ('Dinesh',10),
        ('Nikil',11);
insert into Loan
values(1,'SBI_Chamrajpet',1000),
		(2,'SBI_ResidencyRoad',2000),
        (3,'SBI_ShivajiRoad',3000),
        (4,'SBI_ParliamentRoad',4000),
        (5,'SBI_Jantarmantar',5000);
select *
from Branch;
select *
from Bank_account; 
select *
from Bank_customer;  
select *
from Depositor;  
select *
from Loan;
select Branch_name,Assets/100000 as Assets_in_lakhs
from Branch;
select Customer_name
from Depositor D,Bank_account B
where D.accno=B.accno and Branch_name='SBI_ResidencyRoad'
group by Customer_name
having count(*)>=2;
create view Total_amount_of_loan as
select Branch_name,sum(amount)
from Loan
group by Branch_name;
select *
from Total_amount_of_loan;
create table borrower
(
Customer_name varchar(20),
loanno int,
primary key(Customer_name,loanno),
foreign key(Customer_name)references Bank_customer(Customer_name),
foreign key(loanno) references loan(loanno)
);
insert into borrower
values('avinash',1),
	  ('dinesh',2),
      ('mohan',3),
      ('nikil',4),
      ('ravi',5);
insert into branch
values('sbi_mantrimarg','delhi',200000);
desc branch;
select *from branch;
insert into Bank_account
values(12,'sbi_mantrimarg',2000);
select * from Bank_account;
insert into Depositor
values('nikil',12);
select *from Depositor; 
select Customer_name
from borrower
where Customer_name not in(select Customer_name from Depositor);
select d. Customer_name
from Bank_account a, Branch b, Depositor d
where b.Branch_name=a.Branch_name and
a.accno=d.accno and
b.Branch_city='Delhi'
group by d.Customer_name
having count(b.Branch_name)=(
select count(Branch_name)
from Branch
where Branch_city='Delhi');
delete from Bank_account
where Branch_name in(select Branch_name from Branch where Branch_city="Bombay");
select * from Bank_account;
select Branch_name
from Branch
where assets>all(
select assets from Branch where Branch_city="Bangalore");
update Bank_account
set balance=balance+balance*0.05;
select * from Bank_account;
select Customer_name
from borrower b, loan l
where b.loanno=l.loanno and
Branch_name="Bangalore" and
(Branch_name, Customer_name)in(select Branch_name, Customer_name
from Bank_account a, Depositor d
where a.accno=d.accno);


