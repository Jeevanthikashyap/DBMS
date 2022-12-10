create database employee;
use employee;
create table department
(
	deptno INT,
    dname VARCHAR(30),
    dloc varchar(30),
    primary key(deptno)
);
create table employee
(
	empno INT,
    ename VARCHAR(30),
    mgr_no INT,
    hiredate DATE,
    sal INT,
    deptno INT,
    primary key(empno),
    foreign key(deptno) references department(deptno)
);
create table project
(
	pno INT,
    ploc VARCHAR(30),
    pname VARCHAR(30),
    primary key(pno)
);
create table assigned_to
(
	empno INT,
    pno int,
    jobrole varchar(30),
    primary key(empno,pno),
    foreign key(empno) references employee(empno),
    foreign key(pno) references project(pno)
);
create table incentives
(
	empno INT,
    incentive_date DATE,
    incentive_amt INT,
    primary key(empno,incentive_date),
    foreign key(empno) references employee(empno)
);

insert into department
values(1,"cse","Mysore"),(2,"ise","Bangalore"),(3,"aiml","Hyderabad"),(4,"ece","Chennai"),(5,"civil","Mumbai"),(6,"mechanical","Bangalore");
insert into employee
values(1,"Arun",9,"2000-06-18",20000,1),
		(2,"Rakshitha",9,"2000-02-17",25000,2),
        (3,"Sukruthi",9,"2000-05-05",30000,1),
        (4,"Veeresh",9,"2000-10-20",40000,1),
        (5,"Ranjitha",9,"2000-06-06",45000,2),
        (6,"Nikita",9,"2000-05-20",50000,3),
        (7,"Soujanya",9,"2000-06-16",55000,1),
        (8,"Sanjay",9,"2000-10-10",60000,5),
        (9,"Jyothika",9,"2000-12-11",65000,5),
        (10,"Gouri",9,"2000-01-01",70000,4);
insert into project
VALUES(1,"Bangalore","data analytics"),
(2,"Mysore","microprocessor"),
(3,"Mumbai","site survey"),
(4,"Bangalore","turbo workshop"),
(5,"Chennai","circuit systems"),
(6,"Hyderabad","robotics");
insert into assigned_to
values(2,1,"junior pm"),
(4,2,"Associate"),
(6,6,"accountant"),
(10,5,"accountant");

insert into incentives
values(2,"2005-06-09",2000),
(4,"2005-05-10",4000),
(6,"2005-01-01",6000),
(8,"2005-02-01",8000),
(10,"2005-03-02",10000);
select empno
from assigned_to a, project p
where a.pno=p.pno and p.ploc IN ("Bangalore","Hyderabad","Mysore");
select empno
from employee e
where empno not in(select empno from incentives i);
select e.ename,e.empno,d.dname,a.jobrole,d.dloc,p.ploc
from employee e, department d, project p, assigned_to a
where(e.empno=a.empno and e.deptno=d.deptno and a.pno=p.pno and p.ploc=d.dloc);