SET SERVEROUTPUT ON 
-- Way 1
DECLARE
    counter NUMBER := 0;
    s NUMBER := 0;
BEGIN
    LOOP
        s :=  s + counter;
        counter := counter + 1;
        DBMS_OUTPUT.PUT_LINE('sum is '||s);
        IF s > 2 THEN
            RETURN;
        END IF;
    END LOOP;
END;
-- Way 2 (better) aka Simple Loop
DECLARE
    c2 NUMBER := 0;
    s2 NUMBER := 0;
BEGIN
    LOOP
        s2 :=  s2 + c2;
        c2 := c2 + 1;
        DBMS_OUTPUT.PUT_LINE('sum is '||s2);
        EXIT WHEN s2 > 2;                 
    END LOOP;
END;

-- Way 3 (best)
DECLARE    
    s3 NUMBER := 0;
BEGIN
    FOR i IN 1..3 LOOP
          s3 := s3 + i;
          DBMS_OUTPUT.PUT_LINE('counter is '||i);
          DBMS_OUTPUT.PUT_LINE('sum is '||s3);
        END LOOP;
END;

-- Reverse loop
BEGIN
    FOR i IN REVERSE 3..7 LOOP        
          DBMS_OUTPUT.PUT_LINE('counter is '||i);          
        END LOOP;
END;

-- Skipping values in FOR loop
BEGIN
  FOR j IN 1..5 LOOP
      IF j = 3 THEN -- Skips the value of 3 
        CONTINUE;
      END IF;
      DBMS_OUTPUT.PUT_LINE(j);
    END LOOP;
END;

-- While
DECLARE
    chk INTEGER := 1;
BEGIN
    WHILE chk < 5 LOOP
        chk := dbms_random.value(1, 10);
        DBMS_OUTPUT.PUT_LINE(chk);
    END LOOP;
END;    
