--QUESTIONS
--1)Write a query to find the name of the sailors who reserved red boat
select * from sailors_2611 s inner join reserves_2611 r on s.sid=r.sid inner join boats_2611 b on r.bid=b.bid where b.color='red' ;

SELECT sname FROM sailors_2611 A ,boats_2611 B,reserves_2611 C 
WHERE B.BID=C.BID AND A.SID=C.SID AND  COLOR='red';

--2) Write a query to find the names of sailors who have reserved a red and agreen boat.
 SELECT S1.sname
FROM sailors_2611 S1, reserves_2611 R1, boats_2611 B1
WHERE S1.sid=R1.sid AND R1.bid=B1.bid
 AND B1.color='red' and s1.sid in(SELECT S2.sid
FROM sailors_2611 S2, reserves_2611 R2, boats_2611 B2
WHERE S2.sid=R2.sid AND R2.bid=B2.bid
 AND B2.color='green') ;

--3) Write a query to find the name of sailor who reserved 1 boat
select sid from reserves_2611 group by sid Having COUNT(sid) =1;
select * from sailors_2611 where sid in(select sid from reserves_2611 group by sid Having COUNT(sid) =1);

--4) Write a query to find the sids of all sailors who have reserved red boats but not green boats.(104)
 SELECT S1.sid
FROM sailors_2611 S1, reserves_2611 R1, boats_2611 B1
WHERE S1.sid=R1.sid AND R1.bid=B1.bid
 AND B1.color='red' and s1.sid not in(SELECT S2.sid
FROM sailors_2611 S2, reserves_2611 R2, boats_2611 B2
WHERE S2.sid=R2.sid AND R2.bid=B2.bid
 AND B2.color='green') ;
 
select sid from reserves_2611 r,boats_2611 b where r.bid=b.bid AND b.color='red' and r.sid not in
(select sid from reserves_2611 r,boats_2611 b where r.bid=b.bid
 AND b.color='green'); 

--5) Write a query to find the sailors with the highest rating
select * from sailors_2611 where rating=(select max(rating) from sailors_2611);
select * from sailors_2611 where rating>=all(select rating from sailors_2611);

--6) Write a query to find  the number of sailors elligible to vote
select count(*) from sailors_2611 where age>=18;

--7) Write a query to count different sailors name
select count(distinct(sname)) from sailors_2611;

--8) Write a query to find  the oldest sailor
select * from sailors_2611
where age=(select max(age) from sailors_2611);

--9)Write a query to find name as SAILERNAME,Rating,Age,bname as BOATNAME,Color,Day.
select * from reserves_2611;
select * from boats_2611;
select * from sailors_2611;
select sname,rating ,age,bname as BOATNAME,color,day from sailors_2611 s inner join reserves_2611 r on s.sid=r.sid 
inner join boats_2611 b on r.bid=b.bid;

--10)Write a query to display the sailor name  starts with letter a and b. 
select sname from sailors_2611
where sname like'a%' or sname like 'b%';

--11)Find the names of the Sailors who have reserved at least one boat.
select distinct sname from sailors_2611 s,reserves_2611 r where s.sid=r.sid;

--12)Compute increments for the ratings of persons who have sailed two different boats on the same day.
SELECT distinct S.sname, S.rating+1 AS rating
FROM sailors_2611 S, reserves_2611 R1, reserves_2611 R2
WHERE S.sid=R1.sid AND S.sid=R2.sid
AND R1.day = R2.day AND R1.bid<>R2.bid;

--13)Find the ages of sailors whose name begins and ends with B and has at least 3 characters.
select sname,length(sname) from sailors_2611;
select age from sailors_2611 where sname like 'B%B' and length(sname)>3 ;
 

