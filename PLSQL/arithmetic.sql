--create four separate functions to do addition, subtraction, multiplication, division of two inputs
--addition
create or replace FUNCTION addition (num1 NUMBER,num2 NUMBER)
    RETURN NUMBER                    
  AS                                    
    original NUMBER;
  BEGIN                               
    original := NUM1+NUM2;
    RETURN original;         
END;
select addition(2,32) from dual;

--subtraction
create or replace FUNCTION subtraction (num1 NUMBER,num2 NUMBER)
    RETURN NUMBER                    
  AS                                    
    original NUMBER;
  BEGIN                               
    original := NUM1-NUM2;
    RETURN original;         
END;
select subtraction(2,32) from dual;
select subtraction(32,2) from dual;

--multiplication
create or replace FUNCTION multiplication (num1 NUMBER,num2 NUMBER)
    RETURN NUMBER                    
  AS                                    
    original NUMBER;
  BEGIN                               
    original := NUM1*NUM2;
    RETURN original;         
END;
select multiplication(2,10) from dual;

--division
create or replace FUNCTION division (num1 NUMBER,num2 NUMBER)
    RETURN NUMBER                    
  AS                                    
    original NUMBER;
  BEGIN                               
    original := NUM1/NUM2;
    RETURN original;         
END;
select division(10,0) from dual;
select division(2,32) from dual;
select division(32,2) from dual;

--create a package called as arithmetic by including the above 4 functions
CREATE OR REPLACE PACKAGE arithmetic as
function addition(num1 NUMBER,num2 NUMBER) return number;
function subtraction(num1 NUMBER,num2 NUMBER) return number;
function multiplication(num1 NUMBER,num2 NUMBER) return number;
function division(num1 NUMBER,num2 NUMBER) return number;
end;
/
CREATE OR REPLACE PACKAGE body arithmetic as
    --addition
    FUNCTION addition (num1 NUMBER,num2 NUMBER)
    RETURN NUMBER                    
    AS                                    
    original NUMBER;
    BEGIN                               
        original := NUM1+NUM2;
        RETURN original;         
    END;
    --subtraction
    FUNCTION subtraction (num1 NUMBER,num2 NUMBER)
    RETURN NUMBER                    
    AS                                    
    original NUMBER;
    BEGIN                               
        original := NUM1-NUM2;
        RETURN original;         
    END;
    --multiplication
    FUNCTION multiplication (num1 NUMBER,num2 NUMBER)
    RETURN NUMBER                    
    AS                                    
        original NUMBER;
    BEGIN                               
        original := NUM1*NUM2;
        RETURN original;         
    END;
    --division
    FUNCTION division (num1 NUMBER,num2 NUMBER)
    RETURN NUMBER                    
    AS                                    
    original NUMBER;
     BEGIN                               
    original := NUM1/NUM2;
    RETURN original;         
    END;

END;

--call the function in select statement and in anonymous block

-- CALLING PACKAGE.FUNCTION IN SELECT
SELECT arithmetic.addition(2,10) FROM DUAL;
SELECT arithmetic.subtraction(10,10) FROM DUAL;
SELECT arithmetic.multiplication(2,10) FROM DUAL;
SELECT arithmetic.division(10,2) FROM DUAL;

-- CALLING PACKAGE.FUNCTION IN ANONYMOUS BLOCK
DECLARE
    RESULT NUMBER;
begin
    RESULT := arithmetic.addition(2,10);
    DBMS_OUTPUT.PUT_LINE('result is ' || RESULT);
end;

DECLARE
    RESULT NUMBER;
begin
    RESULT := arithmetic.subtraction(10,10);
    DBMS_OUTPUT.PUT_LINE('RESULT IS ' || RESULT);
end;

DECLARE
    RESULT NUMBER;
begin
    RESULT := arithmetic.multiplication(2,10);
    DBMS_OUTPUT.PUT_LINE('RESULT IS ' || RESULT);
end;

DECLARE
    RESULT NUMBER;
begin
    RESULT :=arithmetic.division(10,2);
    DBMS_OUTPUT.PUT_LINE('RESULT IS ' || RESULT);
end;
