/*
9.	Écrivez une procédure qui utilise des curseurs dynamiques 
pour afficher les informations de tous les employés d'un département 
spécifié par l'utilisateur.
*/
CREATE OR REPLACE PROCEDURE Display_Employee_Info_By_Dept(p_dept_id IN DEPARTMENT.DEPT_ID%TYPE) IS
    -- Déclaration d'un curseur REF CURSOR
    v_cursor SYS_REFCURSOR;
    
    -- Variables pour stocker les données des employés
    v_emp_id EMPLOYEE.EMP_ID%TYPE;
    v_first_name EMPLOYEE.FIRST_NAME%TYPE;
    v_last_name EMPLOYEE.LAST_NAME%TYPE;
    v_start_date EMPLOYEE.START_DATE%TYPE;
    v_title EMPLOYEE.TITLE%TYPE;
    
BEGIN
    -- Ouvrir le curseur dynamique avec une requête basée sur l'ID de département
    OPEN v_cursor FOR
        'SELECT EMP_ID, FIRST_NAME, LAST_NAME, START_DATE, TITLE
         FROM EMPLOYEE
         WHERE DEPT_ID = :1'
         USING p_dept_id;
    
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
END Display_Employee_Info_By_Dept;
/

--Test du procedure 
SET SERVEROUTPUT ON;
EXEC Display_Employee_Info_By_Dept(p_dept_id => 1);
