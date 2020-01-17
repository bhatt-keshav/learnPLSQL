-- Dept table already exists
-- Employee table
-- Create
SET SERVEROUTPUT ON 
CREATE TABLE employee 
    (emp_id NUMBER NOT NULL PRIMARY KEY,
    emp_name VARCHAR2(15),
    emp_dept_id NUMBER,
    emp_loc VARCHAR2(15),
    emp_sal NUMBER,
    CONSTRAINT emp_dept_fk FOREIGN KEY (emp_dept_id) 
     REFERENCES DEPTS(dept_id));

-- Insert INTO Depts 
INSERT INTO DEPTS (dept_id, dept_name) VALUES(1, 'IT');
INSERT INTO DEPTS (dept_id, dept_name) VALUES(2, 'OP');
-- Insert INTO Employee
INSERT INTO employee (emp_id, emp_name, emp_dept_id, emp_loc, emp_sal) VALUES (11, 'tom', 1, 'ca', '100');
INSERT INTO employee (emp_id, emp_name, emp_dept_id, emp_loc, emp_sal) VALUES (21, 'tim', 2, 'ca', '200');
INSERT INTO employee (emp_id, emp_name, emp_dept_id, emp_loc, emp_sal) VALUES (31, 'ton', 1, 'ca', '110');
INSERT INTO employee (emp_id, emp_name, emp_dept_id, emp_loc, emp_sal) VALUES (41, 'tora', 1, 'ca', '140');
INSERT INTO employee (emp_id, emp_name, emp_dept_id, emp_loc, emp_sal) VALUES (51, 'toto', 2, 'ca', '600');
-- Cursor for loop (best way)     
DECLARE
    CURSOR cur_get_emps IS
        SELECT emp_id,
        emp_sal * 0.10 bonus -- alias
        FROM EMPLOYEE;
BEGIN
    FOR cur_get_emps_var IN cur_get_emps LOOP
        DBMS_OUTPUT.PUT_LINE(cur_get_emps_var.emp_id);
        DBMS_OUTPUT.PUT_LINE(cur_get_emps_var.bonus);
    END LOOP;
END;    