--1) Write a query which will display the customer id, account type they hold, their account number and bank name.
SELECT CUSTOMER_ID,ACCOUNT_TYPE,ACCOUNT_NO,BANK_NAME FROM ACCOUNT_INFO_2611,BANK_INFO_2611 
WHERE ACCOUNT_INFO_2611.IFSC_CODE=BANK_INFO_2611.IFSC_CODE;

SELECT CUSTOMER_ID,ACCOUNT_TYPE,ACCOUNT_NO,BANK_NAME FROM ACCOUNT_INFO_2611 A INNER JOIN BANK_INFO_2611 B
ON A.IFSC_CODE=B.IFSC_CODE;

--2) Write a query which will display the customer id, account type and the account number of HDFC customers who registered after 12-JAN-2012 and before 04-APR-2012.
SELECT CUSTOMER_ID,ACCOUNT_TYPE,ACCOUNT_NO FROM ACCOUNT_INFO_2611 WHERE REGISTRATION_DATE BETWEEN '12-JAN-2012' AND '04-APR-2012'
AND IFSC_CODE=(SELECT IFSC_CODE FROM BANK_INFO_2611 WHERE BANK_NAME='HDFC');

--3) Write a query which will display the customer id, customer name, account no, account type and
--bank name where the customers hold the account.
SELECT ACCOUNT.CUSTOMER_ID,ACCOUNT_TYPE,ACCOUNT_NO,CUSTOMER_NAME,BANK_NAME FROM ACCOUNT_INFO_2611 ACCOUNT,CUSTOMER_PERSONAL_INFO_2611
CUSTOMER,BANK_INFO_2611 BANK
WHERE ACCOUNT.CUSTOMER_ID=CUSTOMER.CUSTOMER_ID AND ACCOUNT.IFSC_CODE=BANK.IFSC_CODE;

--4) Write a query which will display the customer id, customer name, gender, marital status 
--along with the unique reference string and sort the records based on customer id in descending order. 
--Hint:  Generate unique reference string as mentioned below 
--Use ""UNIQUE_REF_STRING"" as alias name for displaying the unique reference string."
SELECT CUSTOMER_ID, CUSTOMER_NAME, GENDER, MARITAL_STATUS, 
CONCAT(CUSTOMER_NAME,CONCAT('_',CONCAT(GENDER,CONCAT('_',MARITAL_STATUS)))) AS UNIQUE_REF_STRING
FROM CUSTOMER_PERSONAL_INFO_2611;


--5) Write a query which will display the account number, customer id, registration date, 
--initial deposit amount of the customer
--whose initial deposit amount is within the range of Rs.15000 to Rs.25000.
SELECT CUSTOMER_ID,ACCOUNT_NO,REGISTRATION_DATE,INITIAL_DEPOSIT FROM ACCOUNT_INFO_2611 
where INITIAL_DEPOSIT>=15000 AND INITIAL_DEPOSIT<=25000;

SELECT CUSTOMER_ID,ACCOUNT_NO,REGISTRATION_DATE,INITIAL_DEPOSIT FROM ACCOUNT_INFO_2611 
where INITIAL_DEPOSIT BETWEEN '15000' AND '25000';

--6) Write a query which will display customer id, customer name, date of birth, 
--guardian name of the customers whose name starts with 'J'.
SELECT * FROM CUSTOMER_PERSONAL_INFO_2611;
SELECT  CUSTOMER_ID,CUSTOMER_NAME,DATE_OF_BIRTH,GUARDIAN_NAME  FROM CUSTOMER_PERSONAL_INFO_2611 WHERE CUSTOMER_NAME LIKE'J%';

--7) Write a query which will display customer id, account number and passcode. 
--Hint:  To generate passcode, join the last three digits of customer id and last four digit of account number.
--Example
--: C-001                   1234567898765432                0015432
--. Use ""PASSCODE"" as alias name for displaying the passcode."
SELECT CUSTOMER_ID,ACCOUNT_NO,CONCAT(substr(CUSTOMER_ID,-3),substr(ACCOUNT_NO,-4)) AS PASSCODE FROM ACCOUNT_INFO_2611;

--8) Write a query which will display the customer id, customer name, date of birth, Marital Status, Gender, Guardian name, 
--contact no and email id of the customers whose gender is male 'M' and marital status is MARRIED.
SELECT  CUSTOMER_ID,CUSTOMER_NAME,DATE_OF_BIRTH,MARITAL_STATUS,GENDER,GUARDIAN_NAME,CONTACT_NO,MAIL_ID 
FROM CUSTOMER_PERSONAL_INFO_2611 WHERE MARITAL_STATUS='MARRIED' AND GENDER='M';

--9) Write a query which will display the customer id, customer name, guardian name, reference account 
--holders name of the customers who are referenced / referred by their 'FRIEND'.
SELECT * FROM CUSTOMER_REFERENCE_INFO_2611;
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER_NAME,GUARDIAN_NAME,REFERENCE_ACC_NAME FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER,
CUSTOMER_REFERENCE_INFO_2611 CUSTOMER1 WHERE CUSTOMER.CUSTOMER_ID=CUSTOMER1.CUSTOMER_ID AND CUSTOMER1.RELATION='FRIEND';

--10) Write a query to display the customer id, account number and interest amount in the below format with 
--INTEREST_AMT as alias name Sort the result based on the INTEREST_AMT in ascending order.
--Hint: Need to prefix $ to interest amount and round the result without decimals.
SELECT * FROM ACCOUNT_INFO_2611;
SELECT CUSTOMER_ID,ACCOUNT_NO,CONCAT('$',ROUND(INTEREST,0)) AS INTEREST_AMT FROM  ACCOUNT_INFO_2611 ORDER BY INTEREST DESC;

--11) Write a query which will display the customer id, customer name, account no, account type, activation date,
-- bank name whose account will be activated on '10-APR-2012'
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.CUSTOMER_NAME,ACCOUNT.ACCOUNT_NO,ACCOUNT.ACCOUNT_TYPE,ACCOUNT.ACTIVATION_DATE,BANK.BANK_NAME
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON CUSTOMER.CUSTOMER_ID=ACCOUNT.CUSTOMER_ID
INNER JOIN BANK_INFO_2611 BANK ON BANK.IFSC_CODE=ACCOUNT.IFSC_CODE  WHERE ACCOUNT.ACTIVATION_DATE='10-APR-2012';

--12) Write a query which will display account number, customer id, customer name, bank name, branch name, 
--ifsc code,citizenship, interest and initial deposit amount of all the customers.
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.CUSTOMER_NAME,CUSTOMER.CITIZENSHIP,ACCOUNT.ACCOUNT_NO,ACCOUNT.IFSC_CODE,
ACCOUNT.INTEREST,ACCOUNT.INITIAL_DEPOSIT,BANK.BANK_NAME,BANK.BRANCH_NAME 
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON CUSTOMER.CUSTOMER_ID=ACCOUNT.CUSTOMER_ID
INNER JOIN BANK_INFO_2611 BANK ON BANK.IFSC_CODE=ACCOUNT.IFSC_CODE;

--13) Write a query which will display customer id, customer name, date of birth, guardian name, contact number,
--mail id and reference account holder's name of the customers who has submitted the passport as an identification document.
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER_NAME,DATE_OF_BIRTH,GUARDIAN_NAME,CONTACT_NO,MAIL_ID,IDENTIFICATION_DOC_TYPE,
REF.REFERENCE_ACC_NAME FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER 
INNER JOIN CUSTOMER_REFERENCE_INFO_2611 REF ON CUSTOMER.CUSTOMER_ID=REF.CUSTOMER_ID WHERE IDENTIFICATION_DOC_TYPE='PASSPORT';

--14) Write a query to display the customer id, customer name, account number, account type,
--initial deposit,interest who have deposited maximum amount in the bank.
SELECT * FROM (SELECT CUSTOMER.CUSTOMER_ID, CUSTOMER.CUSTOMER_NAME,ACCOUNT.ACCOUNT_NO, ACCOUNT.ACCOUNT_TYPE, 
ACCOUNT.INITIAL_DEPOSIT, ACCOUNT.INTEREST 
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON CUSTOMER.CUSTOMER_ID = ACCOUNT.CUSTOMER_ID 
GROUP BY CUSTOMER.CUSTOMER_ID, CUSTOMER.CUSTOMER_NAME, ACCOUNT.ACCOUNT_NO,ACCOUNT.ACCOUNT_TYPE, ACCOUNT.INTEREST,
ACCOUNT.INITIAL_DEPOSIT ORDER BY ACCOUNT.INITIAL_DEPOSIT DESC) 
WHERE ROWNUM=1;

--15) Write a query to display the customer id, customer name, account number, account type, interest, 
--bank name and initial deposit amount of the customers who are getting maximum interest rate.
SELECT * FROM(SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.CUSTOMER_NAME,ACCOUNT.ACCOUNT_TYPE,ACCOUNT.ACCOUNT_NO,BANK.BANK_NAME,
ACCOUNT.INITIAL_DEPOSIT, ACCOUNT.INTEREST
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON CUSTOMER.CUSTOMER_ID = ACCOUNT.CUSTOMER_ID 
INNER JOIN BANK_INFO_2611 BANK ON BANK.IFSC_CODE=ACCOUNT.IFSC_CODE
GROUP BY CUSTOMER.CUSTOMER_ID, CUSTOMER.CUSTOMER_NAME, ACCOUNT.ACCOUNT_NO,ACCOUNT.ACCOUNT_TYPE, ACCOUNT.INTEREST,
ACCOUNT.INITIAL_DEPOSIT,BANK.BANK_NAME ORDER BY ACCOUNT.INTEREST DESC) 
WHERE ROWNUM=1;

--16) Write a query to display the customer id, customer name, account no, bank name, contact no and mail id 
--of the customers who are from BANGALORE.
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.CUSTOMER_NAME,ACCOUNT.ACCOUNT_NO,BANK.BANK_NAME,CUSTOMER.CONTACT_NO,CUSTOMER.MAIL_ID,
CUSTOMER.ADDRESS
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON CUSTOMER.CUSTOMER_ID = ACCOUNT.CUSTOMER_ID 
INNER JOIN BANK_INFO_2611 BANK ON BANK.IFSC_CODE=ACCOUNT.IFSC_CODE
WHERE CUSTOMER.ADDRESS LIKE'%BANGALORE';

--17) Write a query which will display customer id, bank name, branch name, ifsc code, registration date,
--activation date of the customers whose activation date is in the month of march (March 1'st to March 31'st).
SELECT ACCOUNT.CUSTOMER_ID,BANK.BANK_NAME,BANK.BRANCH_NAME,BANK.IFSC_CODE,ACCOUNT.REGISTRATION_DATE,ACCOUNT.ACTIVATION_DATE
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON CUSTOMER.CUSTOMER_ID = ACCOUNT.CUSTOMER_ID 
INNER JOIN BANK_INFO_2611 BANK ON BANK.IFSC_CODE=ACCOUNT.IFSC_CODE
WHERE to_char(ACTIVATION_DATE,'MM')=03;

--18) Write a query which will calculate the interest amount and display it along with customer id, customer name, 
--account number, account type, interest, and initial deposit amount.<BR>Hint :Formula for interest amount, 
--calculate: ((interest/100) * initial deposit amt) with column name 'interest_amt' (alias)
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.CUSTOMER_NAME,ACCOUNT.ACCOUNT_NO,ACCOUNT.ACCOUNT_TYPE, ACCOUNT.INTEREST,ACCOUNT.INITIAL_DEPOSIT,
(ACCOUNT.INTEREST/100) * ACCOUNT.INITIAL_DEPOSIT AS INTEREST_AMT
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON CUSTOMER.CUSTOMER_ID = ACCOUNT.CUSTOMER_ID; 

--19) Write a query to display the customer id, customer name, date of birth, guardian name, contact number, 
--mail id, reference name who has been referenced by 'RAGHUL'.
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER_NAME,DATE_OF_BIRTH,GUARDIAN_NAME,CONTACT_NO,MAIL_ID,IDENTIFICATION_DOC_TYPE,
REF.REFERENCE_ACC_NAME FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER 
INNER JOIN CUSTOMER_REFERENCE_INFO_2611 REF ON CUSTOMER.CUSTOMER_ID=REF.CUSTOMER_ID WHERE REF.REFERENCE_ACC_NAME='RAGHUL';

--20) Write a query which will display the customer id, customer name and contact number with ISD code of 
--all customers in below mentioned format.  Sort the result based on the customer id in descending order. 
--Format for contact number is :  
--""+91-3digits-3digits-4digits""
-- Example: +91-924-234-2312
--Use ""CONTACT_ISD"" as alias name."
SELECT CUSTOMER_ID,CUSTOMER_NAME,
CONCAT('+91-',CONCAT(SUBSTR(CONTACT_NO,1,3),CONCAT('-',CONCAT(SUBSTR(CONTACT_NO,4,3),CONCAT('-',SUBSTR(CONTACT_NO,-4))))))
AS CONTACT_ISD FROM CUSTOMER_PERSONAL_INFO_2611 ORDER BY CUSTOMER_ID DESC;

--21) Write a query which will display account number, account type, customer id, customer name, date of birth, guardian name, 
--contact no, mail id , gender, reference account holders name, reference account holders account number, registration date, 
--activation date, number of days between the registration date and activation date with alias name "NoofdaysforActivation", 
--bank name, branch name and initial deposit for all the customers.
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.CUSTOMER_NAME,CUSTOMER.DATE_OF_BIRTH,CUSTOMER.GUARDIAN_NAME,CUSTOMER.CONTACT_NO,
CUSTOMER.GENDER,CUSTOMER.MAIL_ID,ACCOUNT.INITIAL_DEPOSIT,ACCOUNT.ACCOUNT_NO,ACCOUNT.ACCOUNT_TYPE,
ACCOUNT.REGISTRATION_DATE,ACCOUNT.ACTIVATION_DATE,(ACTIVATION_DATE - REGISTRATION_DATE)AS NOOFDAYSFORACTIVATION,
BANK.BANK_NAME,BANK.BRANCH_NAME
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN CUSTOMER_REFERENCE_INFO_2611 REF ON CUSTOMER.CUSTOMER_ID=REF.CUSTOMER_ID
INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON CUSTOMER.CUSTOMER_ID = ACCOUNT.CUSTOMER_ID 
INNER JOIN BANK_INFO_2611 BANK ON BANK.IFSC_CODE=ACCOUNT.IFSC_CODE;

SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER_NAME,DATE_OF_BIRTH,GUARDIAN_NAME,CONTACT_NO,GENDER,MAIL_ID,
INITIAL_DEPOSIT,ACCOUNT_NO,ACCOUNT_TYPE,REGISTRATION_DATE,ACTIVATION_DATE,(ACTIVATION_DATE - REGISTRATION_DATE)AS NOOFDAYSFORACTIVATION,
BANK_NAME,BRANCH_NAME
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER,CUSTOMER_REFERENCE_INFO_2611 REF,ACCOUNT_INFO_2611 ACCOUNT,BANK_INFO_2611 BANK 
WHERE CUSTOMER.CUSTOMER_ID=REF.CUSTOMER_ID
AND CUSTOMER.CUSTOMER_ID = ACCOUNT.CUSTOMER_ID 
AND BANK.IFSC_CODE=ACCOUNT.IFSC_CODE;

--22) Write a query which will display customer id, customer name,  guardian name, identification doc type,
--reference account holders name, account type, ifsc code, bank name and current balance for the customers 
--who has only the savings account. 
--<br/>Hint:  Formula for calculating current balance is add the intital deposit amount and interest
--and display without any decimals. Use ""CURRENT_BALANCE"" as alias name."
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.CUSTOMER_NAME, CUSTOMER.GUARDIAN_NAME, CUSTOMER.IDENTIFICATION_DOC_TYPE, 
REF.REFERENCE_ACC_NAME, ACCOUNT.ACCOUNT_TYPE, BANK.IFSC_CODE, BANK.BANK_NAME,(INITIAL_DEPOSIT + ((INTEREST*INITIAL_DEPOSIT)/100))
AS CURRENT_BALANCE FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER INNER JOIN ACCOUNT_INFO_2611 ACCOUNT ON 
CUSTOMER.CUSTOMER_ID=ACCOUNT.CUSTOMER_ID INNER JOIN BANK_INFO_2611 BANK ON BANK.IFSC_CODE=ACCOUNT.IFSC_CODE 
INNER JOIN CUSTOMER_REFERENCE_INFO_2611 REF ON REF.CUSTOMER_ID=CUSTOMER.CUSTOMER_ID WHERE ACCOUNT_TYPE='SAVINGS';

--23) Write a query which will display the customer id, customer name, account number, account type, interest, 
--initial deposit;check the initial deposit, if initial deposit is 20000 then display ""high"",
--if initial deposit is 16000 display 'moderate', if initial deposit is 10000 display 'average', 
--if initial deposit is 5000 display 'low', if initial deposit is 0 display
-- 'very low' otherwise display 'invalid' and sort by interest in descending order.
--Hint: Name the column as ""Deposit_Status"" (alias). 
--Strictly follow the lower case for strings in this query."
SELECT CUSTOMER.CUSTOMER_ID,CUSTOMER.CUSTOMER_NAME,ACCOUNT.ACCOUNT_NO,ACCOUNT.ACCOUNT_TYPE,ACCOUNT.INTEREST,ACCOUNT.INITIAL_DEPOSIT,
CASE
WHEN INITIAL_DEPOSIT=20000 THEN 'high'
WHEN INITIAL_DEPOSIT=16000 THEN 'moderate'
WHEN INITIAL_DEPOSIT=10000 THEN 'average'
WHEN INITIAL_DEPOSIT=5000 THEN 'low'
WHEN INITIAL_DEPOSIT=0 THEN 'very low'
ELSE 'invalid' END DEPOSIT_STATUS
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER
INNER JOIN ACCOUNT_INFO_2611 ACCOUNT
ON CUSTOMER.CUSTOMER_ID=ACCOUNT.CUSTOMER_ID;

--24) Write a query which will display customer id, customer name,  account number, 
--account type, bank name, ifsc code, initial deposit amount
--and new interest amount for the customers whose name starts with ""J"". 
--<br/> Hint:  Formula for calculating ""new interest amount"" is 
--if customers account type is savings then add 10 % on current interest amount to interest 
--amount else display the current interest amount.
--Round the new interest amount to 2 decimals.<br/> Use ""NEW_INTEREST"" as alias name for displaying the new interest amount.
--<br/>Example, Assume Jack has savings account and his current interest amount 
--is 10.00, then the new interest amount is 11.00 i.e (10 + (10 * 10/100)). "
SELECT CUSTOMER.CUSTOMER_ID, CUSTOMER.CUSTOMER_NAME, ACCOUNT.ACCOUNT_NO, ACCOUNT.ACCOUNT_TYPE, BANK.BANK_NAME, BANK.IFSC_CODE, 
ACCOUNT.INITIAL_DEPOSIT,
CASE
WHEN ACCOUNT_TYPE='SAVINGS' THEN ROUND((INTEREST+(INTEREST*10/100)),2)
ELSE INTEREST END NEW_INTEREST_AMOUNT
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER
INNER JOIN ACCOUNT_INFO_2611 ACCOUNT
ON CUSTOMER.CUSTOMER_ID=ACCOUNT.CUSTOMER_ID
INNER JOIN BANK_INFO_2611 BANK
ON BANK.IFSC_CODE=ACCOUNT.IFSC_CODE
WHERE CUSTOMER.CUSTOMER_NAME LIKE 'J%';


--25) Write query to display the customer id, customer name, account no, initial deposit, tax percentage as calculated below.
--<BR>Hint: <BR>If initial deposit = 0 then tax is '0%'<BR>If initial deposit &lt;= 10000 then tax is '3%' 
--<BR>If initial deposit &gt; 10000 and initial deposit &lt; 20000 then tax is '5%' <BR>If initial deposit &gt;= 20000 and
-- initial deposit&lt;=30000 then tax is '7%' <BR>If initial deposit &gt; 30000 then tax 
--is '10%' <BR>Use the alias name 'taxPercentage'
SELECT CUSTOMER.CUSTOMER_ID, CUSTOMER.CUSTOMER_NAME, ACCOUNT.ACCOUNT_NO, ACCOUNT.INITIAL_DEPOSIT,
CASE
WHEN INITIAL_DEPOSIT=0 THEN '0%'
WHEN INITIAL_DEPOSIT<=10000 THEN '3%'
WHEN INITIAL_DEPOSIT>10000 AND INITIAL_DEPOSIT<20000 THEN '5%'
WHEN INITIAL_DEPOSIT>=20000 AND INITIAL_DEPOSIT<=30000 THEN '7%'
WHEN INITIAL_DEPOSIT>30000 THEN '10%' ELSE 'invalid' END TAX_PERCENTAGE
FROM CUSTOMER_PERSONAL_INFO_2611 CUSTOMER
INNER JOIN ACCOUNT_INFO_2611 ACCOUNT
ON CUSTOMER.CUSTOMER_ID=ACCOUNT.CUSTOMER_ID;
