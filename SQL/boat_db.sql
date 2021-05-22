--Create 3 tables sailors, boats and reserves
 
create table sailors_2611
(
 sid int constraint pk_sid_2611 primary key,
 sname varchar(20),
 rating int,
 age int
);

create table boats_2611
(
 bid int constraint pk_bid_2611 primary key,
 bname varchar(20),
 color varchar(20)
);
 
create table reserves_2611
(
sid int,
constraint fk_sid_2611 foreign key(sid) references sailors_2611(sid),
bid int,
constraint fk_bid_2611 foreign key(bid) references boats_2611(bid),
day date
);
 desc reserves_2611;

insert into sailors_2611 values(22,'dustin',7,45);
insert into sailors_2611 values(29,'brutus',1,39);
insert into sailors_2611 values(31,'lubber',9,55);
insert into sailors_2611 values(32,'andy',8,25);
insert into sailors_2611 values(58,'Rusty',10,35);
 
insert into boats_2611 values(101,'interlake','blue');
insert into boats_2611 values(102,'interlake','red');
insert into boats_2611 values(103,'clipper','green');
insert into boats_2611 values(104,'marine','red');
 
insert into reserves_2611 values(22,101,'1/1/2004');
insert into reserves_2611 values(22,102,'1/1/2004');
insert into reserves_2611 values(22,103,'1/2/2004');
insert into reserves_2611 values(31,103,'5/5/2005');
insert into reserves_2611 values(32,104,'7/4/2005');

DROP TABLE sailors_2611;
DROP TABLE boats_2611;
DROP TABLE reserves_2611;

select * from sailors_2611;
select * from boats_2611;
select * from reserves_2611;