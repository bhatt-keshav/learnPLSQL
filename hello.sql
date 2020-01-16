SET SERVEROUTPUT ON 
DECLARE
    l_num NUMBER;
BEGIN
    l_num := 3;
    DBMS_OUTPUT.PUT_LINE('l_num: ' || l_num);
END;
