create database supplier_catalog;
use supplier_catalog;
create table supplier(
sid int,
sname varchar(30),
city varchar(20),
primary key(sid)
);
desc supplier;
create table parts(
pid int,
pname varchar(30),
color varchar(20),
primary key(pid)
);
desc parts;
create table catalog(
sid int(5),
pid int(5),
cost float(6),
primary key(sid,pid),
foreign key(sid) references supplier(sid),
foreign key(pid) references parts(pid)
);
desc catalog;
insert into supplier
values(10001,'acme widget','bangalore'),
      (10002,'johns','kolkata'),
      (10003,'vimal','mumbai'),
      (10004,'reliance','delhi'),
      (10005,'mahindra','mumbai');
      select *from supplier;
insert into parts
values(20001,'book','red'),
		(20002,'pen','red'),
        (20003,'pencil','green'),
        (20004,'mobile','green'),
        (20005,'charger','black');
        select *from parts;
insert into catalog
values(10001,20001,10),
		(10001,20002,10),
        (10001,20003,30),
        (10001,20004,10),
        (10001,20005,10),
        (10002,20001,10),
        (10002,20002,20),
        (10003,20003,30),
        (10004,20003,40);
select *from catalog;
select distinct p.pname
from parts p, catalog c
where p.pid=c.pid;
select s.sname
from supplier s
where ((select count(p.pid)
		from parts p)=(select count(c.pid)
						from catalog c
                        where c.sid=s.sid));
select c.sid
from catalog c
where c.cost>(select avg(t.cost)
				from catalog t
                where t.pid=c.pid);
select p.pid,s.sname
from parts p, supplier s, catalog c
where c.pid=p.pid and c.sid=s.sid 
and c.cost=(select max(t.cost)
			from catalog t
            where t.pid=p.pid);
select p.pname
from parts p, catalog c,supplier s
where p.pid=c.pid and c.sid=s.sid and s.sname="acme widget"
and not exists(select *
from catalog c1, supplier s1
where p.pid=c1.pid and c1.sid=s1.sid and s1.sname<>"acme widget");
select distinct s.sname
from supplier s, catalog c, parts p
where p.pid=c.pid and c.sid=s.sid and p.color="red";

				


        


