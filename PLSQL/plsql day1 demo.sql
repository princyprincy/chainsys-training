-- 1 HELLO WORLD
BEGIN
   DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
---------------------
-- 2 HELLO 
BEGIN
   DBMS_OUTPUT.put_line ('Hello!');
END;
-------------------
-- 3 VARIABLE DECLARATION
DECLARE
  l_message VARCHAR2( 255 ) :='Hello All!';
BEGIN
  DBMS_OUTPUT.PUT_LINE( l_message );
END; 
-----------------
-- 4 EXCEPTION
DECLARE
      v_result NUMBER;
BEGIN
   v_result := 10 / 0;
    DBMS_OUTPUT.PUT_LINE(V_RESULT );
   EXCEPTION
      WHEN ZERO_DIVIDE THEN
         DBMS_OUTPUT.PUT_LINE( 'SQLERRM' );
END;
-----------------
-- 5 VARIABLE ASSIGNMENT USING =
DECLARE
  l_product_name VARCHAR2( 100 ) := 'MAC MACHINE';
BEGIN
  DBMS_OUTPUT.PUT_LINE(l_product_name );
END;
-----------------
-- 6 VARIABLE ASSIGNMENT USING DEFAULT
DECLARE 
   l_product_name VARCHAR2(100) DEFAULT 'DELL MACHINE';
BEGIN 
   DBMS_OUTPUT.PUT_LINE(l_product_name );
END;
-----------------
-- 7 NOT NULL IN VARIABLES
DECLARE
  l_shipping_status VARCHAR2( 25 ) NOT NULL := 'Shipped';
BEGIN
--  l_shipping_status := '';
  DBMS_OUTPUT.PUT_LINE(l_shipping_status);
END;
------------------
-- 8 BASED ON COLUMN TYPE %TYPE 
DECLARE
  l_customer_name CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_name%TYPE;
  l_CUSTOMER_ID CUSTOMER_PERSONAL_INFO_2611.CUSTOMER_ID%TYPE;
BEGIN
  SELECT
    CUSTOMER_name, CUSTOMER_ID
  INTO
    l_customer_name, l_CUSTOMER_ID
  FROM
    CUSTOMER_PERSONAL_INFO_2611
  WHERE
    customer_id = 'C-001';

  DBMS_OUTPUT.PUT_LINE(l_customer_name || ' : ' || l_cUSTOMER_ID );
END;
---------------------------------
-- 9 VARIABLE ASSIGNMENT
DECLARE
    l_business_partner VARCHAR2(100) := 'Distributor';
    l_lead_for VARCHAR2(100);
BEGIN
    l_lead_for := l_business_partner; 
    DBMS_OUTPUT.PUT_LINE('LEAD FOR : ' || l_lead_for);
END;
---------------------------------
-- 10 Declare user defined type
-- display the max,min,avg interest from the account_info table 
DECLARE
    l_interest   account_info_2611.interest%TYPE;
    l_avg_int     l_interest%TYPE;
    l_max_int     l_interest%TYPE;
    l_min_int     l_interest%TYPE;
BEGIN
    SELECT 
        MIN(interest), 
        MAX(interest), 
        AVG(interest)
    INTO 
        l_min_int,
        l_max_int, 
        l_avg_int
    FROM account_info_2611;
  
    -- show the interest     
    dbms_output.put_line('Min Interest: ' || l_min_int);
    dbms_output.put_line('Max Interest: ' || l_max_int);
    dbms_output.put_line('Avg Interest: ' ||  l_avg_int);
    
END;
---------------------------
-- 11 comments 
-- single line comment
/* 
This is a first line
This is a second line
*/
----------------------------
-- 12 CONSTANTS

DECLARE 
    co_pi     CONSTANT REAL := 3.14159;
    co_radius CONSTANT REAL := 10;
    co_area   CONSTANT REAL := (co_pi * co_radius**2);
BEGIN
--  CO_PI := 23;
    DBMS_OUTPUT.PUT_LINE(co_area);
END;
---------------------------------
-- 13 IF STATEMENT
DECLARE 
    n_sales NUMBER := 2000000; 
BEGIN 
   IF n_sales > 100000 THEN 
      DBMS_OUTPUT.PUT_LINE( 'Sales revenue is greater than 100K ' ); 
   END IF; 
END;
-------------------------------
-- 14 AVOID CLUMSY IF
DECLARE
  B_IS_PROFITABLE BOOLEAN;
  n_sales      NUMBER:=100;
  n_costs      NUMBER:=2 ;
BEGIN
--  b_IS_profitable := false;   
--  IF n_sales > n_costs THEN
--    b_IS_profitable := true;
--  END IF;
 B_IS_PROFITABLE := n_sales > n_costs;
 DBMS_OUTPUT.PUT_LINE( n_sales );
 DBMS_OUTPUT.PUT_LINE( n_costs );
 IF(B_IS_PROFITABLE) THEN
  DBMS_OUTPUT.PUT_LINE( 'PROFIT' );
  ELSE
  DBMS_OUTPUT.PUT_LINE( 'LOSS' );
  END IF;
END;
-------------------------------------------
-- 15 AVOID EVALUATING BOOLEAN VARIABLES
DECLARE
  b_profitable BOOLEAN;
  n_sales      NUMBER:=100;
  n_costs      NUMBER:=2;
BEGIN
  b_profitable := n_sales > n_costs;

IF b_profitable = TRUE THEN
   DBMS_OUTPUT.PUT_LINE( 'This sales deal is profitable' );
END IF;
IF b_profitable THEN
   DBMS_OUTPUT.PUT_LINE( 'This sales deal is profitable' );
END IF;
end;
------------------------------------------------------------
-- 16 IF THEN ELSE
DECLARE
  n_sales NUMBER := 300000;
  n_commission NUMBER( 10, 2 ) := 0;
BEGIN
  IF n_sales > 200000 THEN
    n_commission := n_sales * 0.1;
  ELSE
    n_commission := n_sales * 0.05;
  END IF;
   DBMS_OUTPUT.PUT_LINE(n_commission);
END;
------------------------------------
-- 17 IF THEN ELSIF
DECLARE
  n_sales NUMBER := 300000;
  n_commission NUMBER( 10, 2 ) := 0;
BEGIN
  IF n_sales > 200000 THEN
    n_commission := n_sales * 0.1;
  ELSIF n_sales <= 200000 AND n_sales > 100000 THEN 
    n_commission := n_sales * 0.05;
  ELSIF n_sales <= 100000 AND n_sales > 50000 THEN 
    n_commission := n_sales * 0.03;
  ELSE
    n_commission := n_sales * 0.02;
  END IF;
  DBMS_OUTPUT.PUT_LINE(n_commission);
END;
-----------------------------------
-- 18 NESTED IF - NOT RECOMMENDED
-------------------------------------
-- 19 CASE
DECLARE
  c_grade CHAR( 1 );
  c_rank  VARCHAR2( 20 );
BEGIN
  c_grade := 'b';
  CASE c_grade
  WHEN 'A' THEN
    c_rank := 'Excellent' ;
  WHEN 'B' THEN
    c_rank := 'Very Good' ;
  WHEN 'C' THEN
    c_rank := 'Good' ;
  WHEN 'D' THEN
    c_rank := 'Fair' ;
  WHEN 'F' THEN
    c_rank := 'Poor' ;
  ELSE
    c_rank := 'No such grade' ;
  END CASE;
  DBMS_OUTPUT.PUT_LINE( c_rank );
END;
-------------------------
-- 20 GOTO
BEGIN
  GOTO second_message;

  <<first_message>>
  DBMS_OUTPUT.PUT_LINE( 'Hello' );
  GOTO the_end;

  <<second_message>>
  DBMS_OUTPUT.PUT_LINE( 'PL/SQL GOTO Demo' );
  GOTO first_message;

  <<the_end>>
  DBMS_OUTPUT.PUT_LINE( 'and good bye...' );

END;
-------------------------------------------------
-- 21 NULL
DECLARE
  n_credit_status VARCHAR2( 50 );
BEGIN
  n_credit_status := 'GOOD';

  CASE n_credit_status
  WHEN 'BLOCK' THEN
   DBMS_OUTPUT.PUT_LINE( 'REQUEST FOR APPROVAL' );
  WHEN 'WARNING' THEN
   DBMS_OUTPUT.PUT_LINE( 'SEND EMAIL' );
  ELSE
    NULL;
  END CASE;
END;
------------------------------------------------
-- 22 BASIC LOOP
DECLARE
  l_counter NUMBER := 0;
BEGIN
  LOOP
    l_counter := l_counter + 1;
--    IF l_counter > 3 THEN
--      EXIT;
--    END IF;
    EXIT WHEN l_counter > 3;
    dbms_output.put_line( 'Inside loop: ' || l_counter )  ;
  END LOOP;
  -- control resumes here after EXIT
  dbms_output.put_line( 'After loop: ' || l_counter );
END;
----------------------------------------
-- 23 FOR LOOP
DECLARE
  l_step  PLS_INTEGER := 2;
BEGIN
  FOR l_counter IN REVERSE 1..5
  LOOP
    DBMS_OUTPUT.PUT_LINE( l_counter ||' * ' || l_step ||' = ' || l_counter*l_step );
  END LOOP;
   --DBMS_OUTPUT.PUT_LINE(  l_counter );
  DBMS_OUTPUT.PUT_LINE(  l_step  );
END;
-----------------------------------------------------
create table cars_2611(name varchar2(50));
DECLARE
    L_NAME cars_2611.name%TYPE;
BEGIN 
    SELECT name
    into L_NAME
    FROM cars_2611
    WHERE name='&name';
    DBMS_OUTPUT.PUT_LINE(l_name );
end;
select * from cars_2611;
drop table cars_2611;
-------------------------------------------------------
-- 24 WHILE LOOP
DECLARE
   n_counter NUMBER := 1;
BEGIN
   WHILE n_counter <= 5
      LOOP
        DBMS_OUTPUT.PUT_LINE( 'Counter : ' || n_counter );
        n_counter := n_counter + 1;
        -- EXIT WHEN n_counter = 3;
      END LOOP;
   END;
------------------------------------------------
-- 25 CONTINUE
BEGIN
  FOR n_index IN 1 .. 10
  LOOP
    -- skip odd numbers
    IF MOD( n_index, 2 ) = 1 THEN
      CONTINUE;
    END IF;
    DBMS_OUTPUT.PUT_LINE( n_index );
  END LOOP;
END;
-----------------
BEGIN
  FOR n_index IN 1 .. 10
  LOOP
    -- skip even numbers
    IF MOD( n_index, 2 ) = 0 THEN
      CONTINUE;
    END IF;
    DBMS_OUTPUT.PUT_LINE( n_index );
  END LOOP;
END;



