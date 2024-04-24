/*
	Concevez un déclencheur qui se déclenche à chaque fois qu'un compte est fermé 
pour archiver les informations du compte dans une autre table appelée ACCOUNT_ARCHIVE.
*/

CREATE OR REPLACE TRIGGER Archive_Closed_Account
AFTER UPDATE OF STATUS ON ACCOUNT
FOR EACH ROW
WHEN (NEW.STATUS = 'Closed' AND OLD.STATUS != 'Closed')
BEGIN
    INSERT INTO ACCOUNT_ARCHIVE (
        ACCOUNT_ID,
        AVAIL_BALANCE,
        CLOSE_DATE,
        LAST_ACTIVITY_DATE,
        OPEN_DATE,
        PENDING_BALANCE,
        STATUS,
        CUST_ID,
        OPEN_BRANCH_ID,
        OPEN_EMP_ID,
        PRODUCT_CD,
        ARCHIVE_DATE
    ) VALUES (
        :NEW.ACCOUNT_ID,
        :NEW.AVAIL_BALANCE,
        :NEW.CLOSE_DATE,
        :NEW.LAST_ACTIVITY_DATE,
        :NEW.OPEN_DATE,
        :NEW.PENDING_BALANCE,
        :NEW.STATUS,
        :NEW.CUST_ID,
        :NEW.OPEN_BRANCH_ID,
        :NEW.OPEN_EMP_ID,
        :NEW.PRODUCT_CD,
        SYSDATE
    );
END;
/

--create table archive
CREATE TABLE ACCOUNT_ARCHIVE (
    ACCOUNT_ID NUMBER(10, 0),
    AVAIL_BALANCE FLOAT,
    CLOSE_DATE DATE,
    LAST_ACTIVITY_DATE DATE,
    OPEN_DATE DATE,
    PENDING_BALANCE FLOAT,
    STATUS VARCHAR2(10),
    CUST_ID NUMBER(10, 0),
    OPEN_BRANCH_ID NUMBER(10, 0),
    OPEN_EMP_ID NUMBER(10, 0),
    PRODUCT_CD VARCHAR2(10),
    ARCHIVE_DATE DATE
);

-- test
SELECT * FROM account;
-- Exemple de mise à jour d'un compte
UPDATE ACCOUNT
SET STATUS = 'Closed'
WHERE ACCOUNT_ID = 24; -- Assurez-vous que cet ID de compte existe dans votre base de données

-- Vérifier si les données ont été archivées
SELECT * FROM ACCOUNT_ARCHIVE WHERE ACCOUNT_ID = 24;
