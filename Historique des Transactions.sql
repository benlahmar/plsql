SET SERVEROUTPUT ON;
--select * from  acc_transaction;
--ACCEPT p_account_id PROMPT 'Enter the order number: '
declare
p_account_id ACCOUNT.ACCOUNT_ID%TYPE :=1;
  CURSOR Transaction_Cursor IS
    SELECT TXN_ID, AMOUNT, TXN_DATE, TXN_TYPE_CD, FUNDS_AVAIL_DATE
    FROM ACC_TRANSACTION
    WHERE ACCOUNT_ID = 1
    ORDER BY TXN_DATE DESC;
    
  -- Déclaration de variables pour stocker les données du curseur
  v_txn_id ACC_TRANSACTION.TXN_ID%TYPE;
  v_amount ACC_TRANSACTION.AMOUNT%TYPE;
  v_txn_date ACC_TRANSACTION.TXN_DATE%TYPE;
  v_txn_type_cd ACC_TRANSACTION.TXN_TYPE_CD%TYPE;
  v_funds_avail_date ACC_TRANSACTION.FUNDS_AVAIL_DATE%TYPE;
BEGIN
  -- Ouvrir le curseur
  OPEN Transaction_Cursor;
  
  -- Vérification s'il existe des transactions
 -- FETCH Transaction_Cursor INTO v_txn_id, v_amount, v_txn_date, v_txn_type_cd, v_funds_avail_date;
  IF Transaction_Cursor%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('No transactions found for Account ID: ' || p_account_id);
    RETURN;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Transactions for Account ID: ' || p_account_id);
  END IF;
  
  -- Boucle pour parcourir toutes les lignes retournées par le curseur
  LOOP
    FETCH Transaction_Cursor INTO v_txn_id, v_amount, v_txn_date, v_txn_type_cd, v_funds_avail_date;
    EXIT WHEN Transaction_Cursor%NOTFOUND;
    
    -- Affichage des résultats
    DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_txn_id ||
                         ', Amount: ' || v_amount ||
                         ', Transaction Date: ' || v_txn_date ||
                         ', Transaction Type: ' || v_txn_type_cd ||
                         ', Funds Available Date: ' || v_funds_avail_date);
  END LOOP;
  
  -- Fermer le curseur
  CLOSE Transaction_Cursor;
END;
