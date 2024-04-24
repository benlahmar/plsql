/*
9.	Écrivez une procédure qui utilise des curseurs dynamiques pour afficher 
les informations de tous les employés d'un département spécifié par l'utilisateur.
*/

CREATE OR REPLACE PROCEDURE getEmployerinfo
       (dep department.name%TYPE) 
       IS
           v_cursor SYS_REFCURSOR; 
          dep_id department.dept_id%type;
          
          v_emp_id EMPLOYEE.EMP_ID%TYPE;
        v_first_name EMPLOYEE.FIRST_NAME%TYPE;
        v_last_name EMPLOYEE.LAST_NAME%TYPE;
        v_start_date EMPLOYEE.START_DATE%TYPE;
        v_title EMPLOYEE.TITLE%TYPE;
          
      BEGIN
          select dept_id into dep_id from department where name=dep;
         open v_cursor for 
        'SELECT EMP_ID, FIRST_NAME, LAST_NAME, START_DATE, TITLE
         FROM EMPLOYEE
         WHERE DEPT_ID = :1'
         USING dep_id;
        
         -- Boucle pour lire et afficher les informations de chaque employé
        LOOP
            FETCH v_cursor INTO v_emp_id, v_first_name, v_last_name, v_start_date, v_title;
            EXIT WHEN v_cursor%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_id || ', Name: ' || v_first_name || ' ' || v_last_name ||
                                 ', Start Date: ' || TO_CHAR(v_start_date, 'DD-MON-YYYY') ||
                                 ', Title: ' || v_title);
        END LOOP;
        
        -- Fermer le curseur
        CLOSE v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            IF v_cursor%ISOPEN THEN
                CLOSE v_cursor;
            END IF;
 END getEmployerinfo;



SET SERVEROUTPUT ON;
EXEC getEmployerinfo(dep => 'Operations');


SELECT * FROM department;

SELECT * FROM employee e, department d where e.dept_id=d.dept_id and d.name='Administration'