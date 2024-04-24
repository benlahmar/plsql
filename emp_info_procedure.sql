CREATE OR REPLACE
PROCEDURE get_emp_rs (p_deptno    IN  employee.dept_id%TYPE,
                      p_recordset OUT SYS_REFCURSOR) AS 
BEGIN 
  OPEN p_recordset FOR
    SELECT first_name,
           emp_id,
           dept_id
    FROM   employee
    WHERE  dept_id = p_deptno
    ORDER BY first_name;
END get_emp_rs;
/


SET SERVEROUTPUT ON SIZE 1000000
DECLARE
  l_cursor  SYS_REFCURSOR;
  l_ename   employee.first_name%TYPE;
  l_empno   employee.emp_id%TYPE;
  l_deptno  employee.dept_id%TYPE;
BEGIN
  get_emp_rs (p_deptno    => 1,
              p_recordset => l_cursor);
            
  LOOP 
    FETCH l_cursor
    INTO  l_ename, l_empno, l_deptno;
    EXIT WHEN l_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(l_ename || ' | ' || l_empno || ' | ' || l_deptno);
  END LOOP;
  CLOSE l_cursor;
END;
/