-- 1 DECALRE AND ASSIGN
DECLARE
    A NUMBER(10);
BEGIN
    A := 60;
    DBMS_OUTPUT.PUT_LINE(A);
END;


-- 2 DISPLAY CUSTOMER BASED ON USER INPUT CUSTOMER ID
DECLARE
  l_customer_name CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_NAME%TYPE;
  l_CUSTOMER_ID CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_ID%TYPE;
BEGIN
  SELECT
    CUSTOMER_NAME, CUSTOMER_ID
  INTO
    l_customer_name, l_CUSTOMER_ID
  FROM
    CUSTOMER_PERSONAL_INFO_2611
  WHERE
    customer_id = '&CUSTOMER_ID';
  DBMS_OUTPUT.PUT_LINE(l_customer_name || ' : ' || l_CUSTOMER_ID );
END;


-- 3 USE NUMBER FUNCTION TO FIND GREATEST NUMBER
-- GROUP FUNCTIONS, DECODE CONVERSIONS CANNOT BE USED
-- NUMBER, CHARACTER, DATE FUNCTIONS CAN BE USED 
DECLARE
    A NUMBER(10);
    B NUMBER(10);
    C NUMBER(10);
BEGIN
    A:=40;
    B:=30;
    C:= GREATEST(A,B);
    DBMS_OUTPUT.PUT_LINE(C);
END;


-- 4 ROW LEVEL ATTRIBUTES
-- C IS RECORD TYPE VARIABLE 
-- TRY LOOKING FOR INVALID CUSTOMER_ID 
-- TRY LOOKING FOR DISPLAYING MALE CUSTOMERS
DECLARE 
    C CUSTOMER_PERSONAL_INFO_2611%ROWTYPE;
BEGIN
    SELECT CUSTOMER_ID,CUSTOMER_NAME
    INTO C.CUSTOMER_ID,C.CUSTOMER_NAME
    FROM CUSTOMER_PERSONAL_INFO_2611
    WHERE CUSTOMER_ID ='C-001';
    DBMS_OUTPUT.PUT_LINE( C.CUSTOMER_ID || ' : ' || C.CUSTOMER_NAME );
END;

DECLARE
  l_customer_name CUSTOMER_PERSONAL_INFO_2605.CUSTOMER_NAME%TYPE;
  l_CUSTOMER_ID CUSTOMER_PERSONAL_INFO_2605.CUSTOMER_ID%TYPE;
BEGIN
  SELECT
    CUSTOMER_NAME, CUSTOMER_ID
  INTO
    l_customer_name, l_CUSTOMER_ID
  FROM
    CUSTOMER_PERSONAL_INFO_2605
  WHERE
    customer_ID ='C-001';
    
  DBMS_OUTPUT.PUT_LINE(l_customer_name || ' : ' || l_CUSTOMER_ID );
END;

DECLARE
  l_customer_name customer_PERSONAL_INFO_2605.CUSTOMER_name%TYPE;
  l_CUSTOMER_ID customer_PERSONAL_INFO_2605.CUSTOMER_ID%TYPE;
BEGIN
  SELECT
    CUSTOMER_name, CUSTOMER_ID
  INTO
    l_customer_name, l_CUSTOMER_ID
  FROM
    customer_PERSONAL_INFO_2605
  WHERE
    customer_id = '&CUSTOMER_ID';
    
  DBMS_OUTPUT.PUT_LINE(l_customer_name || ' : ' || l_CUSTOMER_ID );
END;


DECLARE 
    C CUSTOMER_PERSONAL_INFO_2611%ROWTYPE;
BEGIN
    SELECT CUSTOMER_ID,CUSTOMER_NAME
    INTO C.CUSTOMER_ID,C.CUSTOMER_NAME
    FROM CUSTOMER_PERSONAL_INFO_2611
    WHERE GENDER ='F';
    --WHERE GENDER='M'
    DBMS_OUTPUT.PUT_LINE( C.CUSTOMER_ID || ' : ' || C.CUSTOMER_NAME );
END;

-- 5 BIND VARIABLE
VARIABLE LG NUMBER;
DECLARE 
    A NUMBER(10) := 500;
BEGIN
    :LG:=A/2;
    DBMS_OUTPUT.put_line(:LG);
END;

BEGIN
    :LG := 100;
    DBMS_OUTPUT.put_line('VALUE IS ' ||:LG);
END;


-- 6 ASSOCIATIVE ARRAY
DECLARE
    -- declare an associative array type
    TYPE t_capital_type 
        IS TABLE OF VARCHAR2(100) 
        INDEX BY VARCHAR2(50);
    -- declare a variable of the t_capital_type
    t_capital t_capital_type;
    -- local variable
    l_country VARCHAR2(50);
BEGIN
    
    t_capital('USA')            := 'Washington, D.C.';
    t_capital('United Kingdom') := 'London';
    t_capital('Japan')          := 'Tokyo';
    
    l_country := t_capital.FIRST;
    
    WHILE l_country IS NOT NULL LOOP
        dbms_output.put_line('The capital of ' || 
            l_country || 
            ' is ' || 
            t_capital(l_country));
        l_country := t_capital.NEXT(l_country);
    END LOOP;
END;

-- 7 NESTED TABLES
declare
    type number_tab is table of number;
    numb_list number_tab := number_tab(23,56,34,890,21);
begin
    for indx in numb_list.first..numb_list.last loop
        dbms_output.put_line(numb_list(indx));
    end loop;
    numb_list.delete(2);
    numb_list.delete(4);
    dbms_output.put_line('AFTER DELETION');
    for indx in numb_list.first..numb_list.last loop
        if numb_list.exists(indx) then
            dbms_output.put_line(numb_list(indx));
        end if;
    end loop;
end;

-- 8 VARRAY
DECLARE
    TYPE t_name_type IS VARRAY(2) 
        OF VARCHAR2(20) NOT NULL;
    t_names t_name_type  := t_name_type('John','Jane');
    t_enames t_name_type := t_name_type();
BEGIN
    -- initialize to an empty array
    dbms_output.put_line("The number of elements in t_enames " || t_enames.COUNT);
    
    -- initialize to an array of a elements 
    dbms_output.put_line("The number of elements in t_names " || t_names.COUNT);
END;

-- 9 RECORD TYPE
-- 9 RECORD TYPE
DECLARE
    -- creation
    TYPE r_customer_type IS RECORD(
        customer_name customer_PERSONAL_INFO.CUSTOMER_NAME%TYPE,
        INTEREST ACCOUNT_INFO.INTEREST%TYPE
    ); 
    
    -- declaration
    TYPE t_customer_type IS VARRAY(2) 
        OF r_customer_type;

    -- empty array
    t_customers t_customer_type := t_customer_type();
BEGIN
    t_customers.EXTEND;
    t_customers(t_customers.LAST).customer_name := 'ABC Corp';
    t_customers(t_customers.LAST).INTEREST  := 10000;
    
    t_customers.EXTEND;
    t_customers(t_customers.LAST).customer_name := 'XYZ Inc';
    t_customers(t_customers.LAST).INTEREST  := 20000;
    
    dbms_output.put_line('The number of customers is ' || t_customers.COUNT);
END;

-- 10 IMPLICIT CURSOR
BEGIN
    UPDATE CUSTOMER_PERSONAL_INFO_2611
    SET CUSTOMER_NAME = 'JOHN'
    WHERE CUSTOMER_ID = '&ID';
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('RECORD UPDATED');
    ELSE
        DBMS_OUTPUT.PUT_LINE('RECORD NOT FOUND');
    END IF;
END;
-- 11 EXPLICIT CURSOR 
-- DOFC
DECLARE
    CURSOR C IS 
        SELECT CUSTOMER_ID,CUSTOMER_NAME 
        FROM CUSTOMER_PERSONAL_INFO_2611;
    V_ID CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_ID%TYPE;
    V_NAME CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_NAME%TYPE;
BEGIN
    OPEN C;
    LOOP
        FETCH C INTO V_ID,V_NAME;
        EXIT WHEN C%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_ID||' '||V_NAME);
    END LOOP;
    CLOSE C;
END;
-- 12 Implicit Cursor FOR LOOP Statement
BEGIN
  FOR item IN (
    SELECT CUSTOMER_name, CUSTOMER_id
    FROM CUSTOMER_PERSONAL_INFO_2611
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE
      ('Name = ' || item.CUSTOMER_name || ', ID = ' || item.CUSTOMER_id);
  END LOOP;
END;

-- 13 Explicit Cursor FOR LOOP Statement
DECLARE
  CURSOR c1 IS
    SELECT CUSTOMER_name, CUSTOMER_id
    FROM CUSTOMER_PERSONAL_INFO_2611;
BEGIN
  FOR item IN c1
  LOOP
    DBMS_OUTPUT.PUT_LINE
      ('Name = ' || item.CUSTOMER_name || ', ID = ' || item.CUSTOMER_id);
  END LOOP;
END;

-- 14 Passing Parameters to Explicit Cursor FOR LOOP Statement
DECLARE
  CURSOR C1 (ID VARCHAR2) IS
    SELECT * FROM CUSTOMER_PERSONAL_INFO_2611
    WHERE CUSTOMER_ID = ID;
BEGIN
  FOR person IN C1('C-001')
  LOOP
     -- process data record
    DBMS_OUTPUT.PUT_LINE (
      'Name = ' || person.CUSTOMER_name ||
      ' Id = ' || person.CUSTOMER_id
    );
  END LOOP;
END;

-- 15 REFERENCE CURSOR
DECLARE
    TYPE C_REF IS REF CURSOR;
    C C_REF;
    STMT VARCHAR2(200) := 'SELECT CUSTOMER_ID,CUSTOMER_NAME 
        FROM CUSTOMER_PERSONAL_INFO_2611';
    V_ID CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_ID%TYPE;
    V_NAME CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_NAME%TYPE;
BEGIN
    OPEN C FOR STMT;
    LOOP
        FETCH C INTO V_ID,V_NAME;
        EXIT WHEN C%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_ID||' '||V_NAME);
    END LOOP;
    CLOSE C;
END;

-- 16 PROCESDURE
CREATE OR REPLACE PROCEDURE print_contact_2611(
    in_customer_id CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_ID%TYPE  
)
IS
  r_contact CUSTOMER_PERSONAL_INFO_2611%ROWTYPE;
BEGIN
  -- get contact based on customer id
  SELECT *
  INTO r_contact
  FROM CUSTOMER_PERSONAL_INFO_2611
  WHERE customer_id = IN_customer_id;

  -- print out contact's information
  dbms_output.put_line( r_contact.CUSTOMER_name || ' ' ||
  r_contact.GUARDIAN_name || '<' || r_contact.mail_ID ||'>' );

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( SQLERRM );
END;

EXECUTE print_contact_2611('C-001');
EXEC print_contact_2611('C-001');

-- 17 Assigning Value to Variable as IN OUT Subprogram Parameter
DECLARE
  CUS_INT  NUMBER(8,2);
 
  PROCEDURE adjust_INTEREST (
    INTEREST IN OUT NUMBER,
    adjustment NUMBER
  ) IS
  BEGIN
    INTEREST := INTEREST + adjustment;
  END;
 
BEGIN
  SELECT INTEREST INTO CUS_INT
  FROM ACCOUNT_INFO_2611
  WHERE ACCOUNT_NO = 1234567898765432;
 
  DBMS_OUTPUT.PUT_LINE
   ('Before invoking procedure, INTEREST: ' || CUS_INT);
 
  adjust_INTEREST (CUS_INT, 10);
 
  DBMS_OUTPUT.PUT_LINE
   ('After invoking procedure, INTEREST: ' || CUS_INT);
END;

-- 18 Declaring, Defining, and Invoking a Simple PL/SQL Function
DECLARE
  -- Declare and define function

  FUNCTION square (original NUMBER)   -- parameter list
    RETURN NUMBER                     -- RETURN clause
  AS
                                      -- Declarative part begins
    original_squared NUMBER;
  BEGIN                               -- Executable part begins
    original_squared := original * original;
    RETURN original_squared;          -- RETURN statement
  END;
BEGIN
  DBMS_OUTPUT.PUT_LINE(square(100));  -- invocation
END;

-- 19 FUNCTION
create or replace FUNCTION cubic (original NUMBER)
    RETURN NUMBER                    
  AS                                    
    original_cube NUMBER;
  BEGIN                               
    original_cube := original * original * original;
    RETURN original_cube;         
END;
select cubic(2) from dual;

-- 20 PACKAGE 
CREATE OR REPLACE PACKAGE cus_mgmt as
function cubic(original NUMBER) return number;
PROCEDURE print_contact(
    in_customer_id CUSTOMER_PERSONAL_INFO.CUSTOMER_ID%TYPE  
);
end;

CREATE OR REPLACE PACKAGE body cus_mgmt as
function cubic(original NUMBER) return number
AS                                    
    original_cube NUMBER;
  BEGIN                               
    original_cube := original * original * original;
    RETURN original_cube;         
END;
PROCEDURE print_contact(
    in_customer_id CUSTOMER_PERSONAL_INFO.CUSTOMER_ID%TYPE  
)
IS
  r_contact CUSTOMER_PERSONAL_INFO%ROWTYPE;
BEGIN
  -- get contact based on customer id
  SELECT *
  INTO r_contact
  FROM CUSTOMER_PERSONAL_INFO
  WHERE customer_id = IN_customer_id;

  -- print out contact's information
  dbms_output.put_line( r_contact.CUSTOMER_name || ' ' ||
  r_contact.GUARDIAN_name || '<' || r_contact.mail_ID ||'>' );

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( SQLERRM );
END;
end;
-- CALLING PACKAGE.FUNCTION IN SELECT
SELECT cus_mgmt.cubic(2) FROM DUAL;
-- CALLING PACKAGE.FUNCTION IN ANONYMOUS BLOCK
DECLARE
    RESULT NUMBER;
begin
    RESULT := cus_mgmt.cubic(2);
    DBMS_OUTPUT.PUT_LINE('CUBIC IS ' || RESULT);
end;
-- CALLING PACKAGE.PROCEDURE IN ANONYMOUS BLOCK
begin
    cus_mgmt.print_contact('C-001');
end;
-- EXECUTING PACKAGE.PROCEDURE IN EXECUTE STATEMENT
EXEC cus_mgmt. print_contact('C-001');
-- to read erros
select * from user_errors;
