/*
	D�veloppez un trigger qui met � jour la date de derni�re activit� (LAST_ACTIVITY_DATE) dans 
la table ACCOUNT chaque fois qu'une transaction est enregistr�e dans ACC_TRANSACTION.
*/



CREATE OR REPLACE TRIGGER Update_Last_Activity_Date
AFTER INSERT ON ACC_TRANSACTION
FOR EACH ROW
BEGIN
    UPDATE ACCOUNT
    SET LAST_ACTIVITY_DATE = SYSDATE
    WHERE ACCOUNT_ID = :NEW.ACCOUNT_ID;
END;

/

