show databases;
create database supplier_product;
use supplier_product;
create table sp_table
(
supplier_num varchar(10),
product_num varchar(10),
quantity int,
primary key(supplier_num,product_num)
);
desc sp_table;
insert into sp_table
values('s01','p01','10'),('s02','p02','30'),('s03','p03','50'),('s04','p04','70'),('s05','p05','500');
select *
from sp_table
where quantity between 50 and 500;