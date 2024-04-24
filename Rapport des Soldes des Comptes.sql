SET SERVEROUTPUT ON;
declare
  CURSOR Account_Cursor IS
    SELECT ACCOUNT_ID, AVAIL_BALANCE, STATUS
    FROM ACCOUNT
    ORDER BY STATUS, ACCOUNT_ID;

  -- Déclaration de variables pour stocker les données du curseur
  v_account_id ACCOUNT.ACCOUNT_ID%TYPE;
  v_avail_balance ACCOUNT.AVAIL_BALANCE%TYPE;
  v_status ACCOUNT.STATUS%TYPE;
BEGIN
  -- Ouvrir le curseur
  OPEN Account_Cursor;
  
  -- Boucle pour parcourir toutes les lignes retournées par le curseur
  LOOP
    FETCH Account_Cursor INTO v_account_id, v_avail_balance, v_status;
    EXIT WHEN Account_Cursor%NOTFOUND;
    
    -- Affichage des résultats
    DBMS_OUTPUT.PUT_LINE('Account ID: ' || v_account_id || 
                         ', Available Balance: ' || v_avail_balance || 
                         ', Status: ' || v_status);
  END LOOP;
  
  -- Fermer le curseur
  CLOSE Account_Cursor;
END ;
