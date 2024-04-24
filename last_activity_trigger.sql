/*
	Développez un trigger qui met à jour la date de dernière activité (LAST_ACTIVITY_DATE) dans 
la table ACCOUNT chaque fois qu'une transaction est enregistrée dans ACC_TRANSACTION.
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

