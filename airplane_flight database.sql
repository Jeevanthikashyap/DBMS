create database airlineflights;
use airlineflights;
create table flights(
flno int,
ffrom varchar(30),
fto varchar(30),
distance int,
departs time,
arrives time,
price int,
primary key(flno)
);
create table aircraft(
aid int,
aname varchar(30),
cruising_range int,
primary key(aid)
);
create table certified(
eid int,
aid int,
primary key(eid,aid),
foreign key(aid)references aircraft(aid)
);
create table employees(
eid int,
ename varchar(30),
salary int,
foreign key(eid)references certified(eid)
);
insert into flights
values(1,'bengaluru','new delhi',500,'6:00','9:00',5000),
		(2,'bengaluru','chennai',300,'7:00','8:30',3000),
        (3,'trivandrum','new delhi',800,'8:00','11:30',6000),
        (4,'bengaluru','frankfurt',10000,'6:00','23:30',50000),
        (5,'kolkata','new delhi',2400,'11:00','3:30',9000),
        (6,'bengaluru','frankfurt',8000,'9:00','23:00',40000);
select *from flights;
insert into aircraft
values(1,'airbus',2000),
		(2,'boeing',700),
        (3,'jet airways',550),
        (4,'indigo',5000),
        (5,'boeing',4500),
        (6,'airbus',2200);
        select *from aircraft;
insert into certified
values(101,2),
		(101,4),
        (101,5),
        (101,6),
        (102,1),
        (102,3),
        (102,5),
        (103,2),
        (103,3),
        (103,5),
        (103,6),
        (104,6),
        (104,1),
        (104,3),
        (105,3);
insert into employees
values(101,'avinash',50000),
		(102,'lokesh',60000),
        (103,'rakesh',70000),
        (104,'santhosh',82000),
        (105,'tilak',5000);
select *from employees;

select aname
from aircraft
where aid in(select aid from certified
				where eid in(select eid from employees
								where salary>=80000));

select c.eid,max(a.cruising_range)
from certified c, aircraft a
where a.aid=c.aid 
group by c.eid
having count(c.aid)>=3;

select ename
from employees
where salary<(select min(price)
				from flights
                where ffrom='bengaluru' and fto='frankfurt');

select a.aid,a.aname,avg(e.salary)
from aircraft a, certified c, employees e
where a.aid=c.aid and c.eid=e.eid and a.cruising_range>1000
group by a.aid, a.aname;

select distinct ename
from employees e, certified c, aircraft a
where e.eid=c.eid and a.aid=c.aid and a.aname='boeing';

select distinct a.aid 
from aircraft a
where a.cruising_range>(select min(f.distance)
						from flights f
                        where f.ffrom='bengaluru' and f.fto='new delhi');
