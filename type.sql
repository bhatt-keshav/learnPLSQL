SET SERVEROUTPUT ON 
-- Only need to create table one time, then comment it's construction
--create table depts
--(   dept_id number not null primary key,
--    dept_name VARCHAR(60));

--Shows setting type and inheriting--
DECLARE
  l_num NUMBER(5,2) NOT null default 2.21;
  l_num_vartype l_num%TYPE := 1.123;
  l_num_coltype depts.dept_id%TYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('l_num_vartype assigned value 1.123. Final value ' ||l_num_vartype);
  DBMS_OUTPUT.PUT_LINE('l_num_coltype assigned no value. Final value ' ||l_num_coltype);
END;    

-- Type promotion and rounding error with binary nrs -- 
DECLARE
    n NUMBER := 0.51;
    b BINARY_FLOAT := 2;
    c BINARY_FLOAT;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Expected 1.02, but multiplication resulted in ' || n * b) ; -- nr got converted to binary float
    DBMS_OUTPUT.PUT_LINE('result of div by zero ' || b/0) ;
    c := b/0; -- will not throw an error
    DBMS_OUTPUT.PUT_LINE(c+1);  -- will not throw an error, just gives Inf as o/p
END;

-- dates example --
-- time (zones)
-- change to eastern time
alter session set time_zone = 'EST';  
SELECT current_timestamp, SYSTIMESTAMP FROM DUAL; -- systimestamp is of server and cannot be changed 
-- change back to default
alter session set time_zone = 'EUROPE/BERLIN'; 
SELECT current_timestamp, SYSTIMESTAMP FROM DUAL;

DECLARE
  d1 DATE := current_date;
  d2 TIMESTAMP WITH TIME ZONE := SYSTIMESTAMP;
  d22 TIMESTAMP WITH TIME ZONE := current_timestamp;
  d3 TIMESTAMP :=  current_timestamp;
  n NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE(d1); -- 14-JAN-20
  DBMS_OUTPUT.PUT_LINE(d2); -- 14-JAN-20 02.06.26.269000 PM +01:00
  DBMS_OUTPUT.PUT_LINE(d22); -- 14-JAN-20 02.09.26.460000 PM EUROPE/BERLIN
  DBMS_OUTPUT.PUT_LINE(d3); -- 14-JAN-20 02.06.26.269000 PM
END;
/
-- time difference (interval datatype)
DECLARE
  t2 TIMESTAMP(2) WITH TIME ZONE := to_timestamp_tz('2019-01-25 21:15:53.46 +02:00',
                        'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM');
  t1 TIMESTAMP (2) WITH TIME ZONE :=  to_timestamp_tz('2019-01-21 21:05:53.46 +02:00',
                        'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM');
  t3 TIMESTAMP WITH TIME ZONE := to_timestamp_tz('2020-03-21 21:05:53.46 +02:00',
                        'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM');                       
  ym INTERVAL YEAR to MONTH; 
  ds INTERVAL DAY(2) to SECOND(2);  
BEGIN
  DBMS_OUTPUT.PUT_LINE(t2);
  DBMS_OUTPUT.PUT_LINE(t1);
  ds := t2 - t1;  -- defaults to DAY TO SECOND
  DBMS_OUTPUT.PUT_LINE(ds);
  DBMS_OUTPUT.PUT_LINE(t3);
  ym := (t3-t1) year to month; -- this is the only way to make this work, apparently the default interval diff is day to sec
  DBMS_OUTPUT.PUT_LINE(ym);
END;

-- Records
-- table is already created
DECLARE
TYPE EmpRec IS RECORD (
    employee_id NUMBER,
    dept_id depts.dept_id%TYPE,
    loc VARCHAR2(10) DEFAULT 'CA');
l_emprec EmpRec; -- sets type of local var as record type
BEGIN
-- these values didn't exist in the dept table
  l_emprec.employee_id := 2147483647; 
  l_emprec.dept_id := 1;
-- but are present only in the record scope  
  DBMS_OUTPUT.PUT_LINE('employee id is '||l_emprec.employee_id);
  DBMS_OUTPUT.PUT_LINE('employee dept is '||l_emprec.dept_id);
END;
-- Nesting of Records
DECLARE
TYPE EmpRec IS RECORD (
    employee_id NUMBER,
    deptrec depts%ROWTYPE,
    loc VARCHAR2(10) DEFAULT 'CA');
    l_emprec EmpRec;
BEGIN
-- these values didn't exist in the dept table
  l_emprec.employee_id := 2147483647; 
  l_emprec.deptrec.dept_id := 27;
-- but are present only in the record scope  
  DBMS_OUTPUT.PUT_LINE('employee id is '||l_emprec.employee_id);
  DBMS_OUTPUT.PUT_LINE('employee dept is '||l_emprec.deptrec.dept_id);
END;

