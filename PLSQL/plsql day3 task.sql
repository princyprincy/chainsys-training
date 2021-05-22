--CREATE A PROCEDURE TO DEPOSIT (USE TX TRIGGER TO ADD A TX ENTRY(CREDIT/DEBIT) LIKE AUDIT), WITHDRAW, FUND TRANSFER. 
--
--PROCEDURE SHOULD RETURN ERROR MESSAGE 
--	INVALID ACCOUNT NUMBER
--	ACCOUNT IS LOCKED (TX SHOULDNT HAPPEN)
--	THROW INSUFFIENT BALANCE EXPECTION.
--	MANAGE TX COMMIT AND ROLLBACK(IF ANY EXPECTION)
CREATE OR REPLACE TRIGGER Trans
AFTER INSERT ON TRANSACTION3
FOR EACH ROW
BEGIN
    IF(:NEW.ACC_TYPE='WITHDRAW') THEN
        UPDATE account32 SET BALANCE=BALANCE-:NEW.AMOUNT WHERE ACC_NO=:NEW.ACC_NO;
    ELSIF (:NEW.ACC_TYPE='DEPOSIT') THEN
        UPDATE account32 SET BALANCE=BALANCE+:NEW.AMOUNT WHERE ACC_NO=:NEW.ACC_NO;
--    ELSIF (:NEW.TYPE='TRANSFER') THEN
--        UPDATE SET BALANCE=BALANCE-:NEW.AMOUNT WHERE ACCOUNT_NO=:NEW.ACC_NO;
--        UPDATE SET BALANCE=BALANCE+:NEW.AMOUNT WHERE ACCOUNT_NO=:NEW.ACC_NO;
--     ELSE
--          DBMS_OUTPUT.PUT_LINE('TYPE COULD BE WITHDRAW OR DEPOSIT');

END IF;
END;

INSERT INTO TRANSACTION3 VALUES('DEPOSIT',1000,500);
INSERT INTO TRANSACTION32 VALUES('WITHDRAW',1000,500);






CREATE TABLE ACCOUNT32
(
ACC_NO NUMBER(4),
CUST_NAME VARCHAR2(20),
BALANCE NUMBER(10),
STATUS VARCHAR2(10)
);
drop table ACCOUNT32;
SELECT * FROM ACCOUNT32;
INSERT INTO ACCOUNT32 VALUES(1000,'PRINCY',23000,'OPENED');
INSERT INTO ACCOUNT32 VALUES(1001,'PRIYA',5000,'OPENED');
INSERT INTO ACCOUNT32 VALUES(1002,'ANAND',10000,'CLOSED');

CREATE TABLE TRANSACTION3
(
ACC_TYPE VARCHAR(10),
ACC_NO NUMBER(4),
AMOUNT NUMBER(10)
);
drop table TRANSACTION32;
SELECT * FROM TRANSACTION3;