--Questions
--1. display the number of books published in year 2004
--2. Display month and number of books published for each month in the 2004 year
--3. Display Title ID and number of authors of the title
SELECT TITLEID,COUNT(AUID) FROM TITLEAUTHORS_2611 GROUP BY TITLEID;

--4. Display how many titles author 103 wrote as the lead author
SELECT COUNT(TITLEID) FROM TITLEAUTHORS_2611 WHERE AUID=103 and importance=1;

--5. Display Publisher name and number of books published
--SELECT A.PNAME,A.PUBID FROM PUBLISHERS_2611 A,TITLES_2611 B WHERE A.PUBID=B.PUBID ;
--SELECT A.PUBID,COUNT(A.PUBID) FROM  PUBLISHERS_2611 A,TITLES_2611 B WHERE A.PUBID=B.PUBID GROUP BY A.PUBID;
--SELECT PUBID,COUNT(PUBID) FROM TITLES_2611 GROUP BY PUBID;
SELECT A.PNAME,COUNT(A.PNAME) FROM PUBLISHERS_2611 A,TITLES_2611 B WHERE A.PUBID=B.PUBID GROUP BY A.PNAME;

--6. Display the subjects for which we have the average price in the range 400 to 500
SELECT * FROM TITLES_2611 WHERE PRICE BETWEEN 400 AND 500;

--7. Display the publisher who published more than OR EQUAL 1 book on JAVA
SELECT DISTINCT PUBID FROM TITLES_2611  WHERE SUBID='JAVA' ;
SELECT * FROM PUBLISHERS_2611 WHERE PUBID IN (SELECT DISTINCT PUBID FROM TITLES_2611  WHERE SUBID='JAVA' );

--8. Display the author who has written the costliest book.
SELECT * FROM AUTHORS_2611 WHERE AUID IN(SELECT AUID FROM TITLEAUTHORS_2611 WHERE TITLEID IN
(SELECT TITLEID FROM TITLES_2611 WHERE PRICE=(SELECT MAX(PRICE) FROM TITLES_2611)));

--9. Display year and number of books published where the book is written by more than one author

--10.Display author and number of books by the author from publisher WROX
