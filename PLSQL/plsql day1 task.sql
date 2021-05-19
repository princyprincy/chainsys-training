--Write a PL/SQL program to arrange the number of two variable in such a
--way that the small number will store in num_small variable and large number will store in num_large variable.
DECLARE 
    num1 NUMBER:=3;
    num2 NUMBER:=1;
    num_small NUMBER;
    num_large NUMBER;
BEGIN
    IF num1>num2 THEN
        num_large:=num1;
        num_small:=num2;
    ELSE
        num_large:=num2;
        num_small:=num1;
    END IF;
     dbms_output.put_line('SMALL NUMBER: ' || num_small);
    dbms_output.put_line('LARGE NUMBER: ' || num_large);
   
END;


--2.Write a PL/SQL program to check whether a given character is letter or digit.
declare
 char1 char(1):='0';
 BEGIN
    IF ( char1 >= 'A' AND char1 <= 'Z' ) OR ( char1 >= 'a' AND char1 <= 'z' ) THEN
      dbms_output.Put_line ('The given character is a letter');
    ELSIF char1 BETWEEN '0' AND '9' THEN
        dbms_output.Put_line ('The given character is a number');
    ELSE
      dbms_output.Put_line ('The given character is not a letter and number');
    end if;
end;

--3.Write a program in PL/SQL to print the value of a variable inside and outside a loop using LOOP WHEN EXIT statement.
DECLARE
  l_counter NUMBER := 0;
BEGIN
  LOOP
    l_counter := l_counter + 1;
    EXIT WHEN l_counter > 3;
    dbms_output.put_line( 'Inside loop: ' || l_counter )  ;
  END LOOP;
  -- control resumes here after EXIT
  dbms_output.put_line( 'After loop: ' || l_counter );
END;

--4.Write a PL/SQL program to display which day is a specific date
DECLARE 
   DT DATE := TO_DATE('05-MAR-2000','DD-MON-YYYY');
   DT_DAY VARCHAR(1);

BEGIN
   DT_DAY := TO_CHAR(DT,'D');
   DBMS_OUTPUT.PUT_LINE(DT);

CASE DT_DAY
WHEN '1' THEN
DBMS_OUTPUT.PUT_LINE('SUNDAY');
WHEN '2' THEN
DBMS_OUTPUT.PUT_LINE('MONDAY');
WHEN '3' THEN
DBMS_OUTPUT.PUT_LINE('TUESDAY');
WHEN '4' THEN
DBMS_OUTPUT.PUT_LINE('WEDNESDAY');
WHEN '5' THEN
DBMS_OUTPUT.PUT_LINE('THURSDAY');
WHEN '6' THEN
DBMS_OUTPUT.PUT_LINE('SATURDAY');
END CASE;
END;

--5.Write a PL/SQL procedure to calculate the incentive on a specific target otherwise
-- a general incentive to be paid using IF-THEN-ELSE.
DECLARE
  PROCEDURE test1 (
    sal_achieve  NUMBER,
    target_qty  NUMBER,
    emp_id NUMBER
  )
  IS
    incentive   NUMBER := 0;

  BEGIN
    IF sal_achieve > (target_qty + 200) THEN
      incentive := (sal_achieve - target_qty)/4;
ELSE
 incentive :=75;
END IF;
DBMS_OUTPUT.PUT_LINE ('incentive = ' || incentive);
      UPDATE EMPLOYEES_2611_
      SET salary = salary + incentive 
      WHERE employee_id = emp_id;
   
  END test1;
BEGIN
  test1(2300, 2000, 100);
  test1(3600, 3000, 101);
END;


--6.Write a PL/SQL block to calculate the incentive of an employee whose ID is 110.

--DECLARE
--    g_incentive number := 1000;
--    s_incentive number := 1200;
--    l_salary number := 1000;
--BEGIN 
--    if l_salary < 1000 THEN
--    dbms_output.put_line( 'general incentive' || g_incentive + l_salary);
--    else
--    dbms_output.put_line( 's_incentive'|| s_incentive + l_salary );
--    end if;
--end;

DECLARE
  incentive   NUMBER(20);
BEGIN
  SELECT salary * 0.5 INTO incentive
  FROM EMPLOYEES_2611_  
  WHERE EMPLOYEE_id = 101;
DBMS_OUTPUT.PUT_LINE('Incentive  = ' || incentive);
END;

--7. Write a block to display name, contact no and no of rows from employee table.

DECLARE
    CURSOR C1 IS 
        SELECT EMPLOYEE_ID id,FIRST_NAME 
        FROM employees_2611_ ;
    V_ID employees_2611_.EMPLOYEE_ID%TYPE;
    V_NAME employees_2611_.FIRST_NAME%TYPE;
    COUNT_EMP NUMBER(10):=0;
    COUNT_EM NUMBER(10):=0;

BEGIN
    OPEN C1;
    LOOP
        FETCH C1 INTO V_ID,V_NAME;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_ID||' '||V_NAME);
        COUNT_EMP:=COUNT_EMP+1;
    END LOOP;
--    SELECT COUNT(EMPLOYEE_ID) INTO COUNT_EM
--   FROM employees_2611_
--   WHERE employee_id = V_ID;
    DBMS_OUTPUT.PUT_LINE('NO OF ROWS IN THE TABLE = ' ||COUNT_EMP);
    DBMS_OUTPUT.PUT_LINE('NO OF ROWS IN THE TABLE = ' ||COUNT_EM);
    CLOSE C1;
END;

--8.To develop a procedure named adjust_salary() sample database.
-- We’ll update the salary information of employees in the employees table by 
--using SQL UPDATE statement.

CREATE PROCEDURE adjust_salary32
(
    in_employees_id IN EMPLOYEES_2611_.EMPLOYEE_ID%TYPE
    
) IS
BEGIN
    UPDATE EMPLOYEES_2611_
    SET salary = 24000
    WHERE employee_id = '&ID';
END;

drop procedure adjust_salary2611;
CREATE PROCEDURE adjust_salary3
(
    in_employee_id IN EMPLOYEES_2611_.EMPLOYEE_ID%TYPE,
    in_percent IN NUMBER
) IS
BEGIN
   UPDATE employees_2611_
   SET salary = salary + salary * in_percent / 100
   WHERE employee_id = in_employee_id;
END;

SELECT * FROM employees_2611_;
--24000
-- call procedure
exec adjust_salary3(100,5);
-- after adjustment
SELECT * FROM employees_2611_;
--25200