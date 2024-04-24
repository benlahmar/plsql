/*
3.	Concevez un déclencheur qui se déclenche à chaque fois qu'un compte est fermé 
pour archiver les informations du compte dans une autre table appelée ACCOUNT_ARCHIVE.
*/

create or replace TRIGGER avantinsertemp 
    BEFORE
        INSERT ON employee
BEGIN
    IF (TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')) 
        OR (TO_CHAR(SYSDATE,'HH24:MI') NOT BETWEEN '08:00' AND '18:00')
           THEN RAISE_APPLICATION_ERROR (-20500,'You may insert into EMPLOYEES table only during business hours.');
    END IF;
END;
 /
 
INSERT INTO employee (EMP_ID, FIRST_NAME, LAST_NAME, START_DATE, TITLE)
VALUES (300, 'habib', 'moi',  SYSDATE, 'Loan Manager');

select * from employee




