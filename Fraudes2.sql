SET SERVEROUTPUT ON;
declare
-- Seuil pour considérer une transaction comme suspecte, ici défini comme 3 fois la moyenne des transactions
  c_threshold_multiplier NUMBER := 1;

  CURSOR Account_Cursor IS
    SELECT ACCOUNT_ID
    FROM ACCOUNT;

  v_account_id ACCOUNT.ACCOUNT_ID%TYPE;
  v_avg_amount NUMBER;
  v_large_txn_id ACC_TRANSACTION.TXN_ID%TYPE;
  v_large_amount ACC_TRANSACTION.AMOUNT%TYPE;
  v_large_txn_date ACC_TRANSACTION.TXN_DATE%TYPE;

BEGIN
  -- Parcourir tous les comptes
  OPEN Account_Cursor;
  LOOP
    FETCH Account_Cursor INTO v_account_id;
    EXIT WHEN Account_Cursor%NOTFOUND;

    -- Calculer la moyenne des transactions pour le compte courant
    SELECT AVG(AMOUNT)
    INTO v_avg_amount
    FROM ACC_TRANSACTION
    WHERE ACCOUNT_ID = v_account_id;
    
    --.PUT_LINE(v_account_id || '    ' || v_avg_amount);
    
    
    -- Identifier les transactions qui dépassent le seuil de suspicion
    FOR r IN (
      SELECT TXN_ID, AMOUNT, TXN_DATE
      FROM ACC_TRANSACTION
      WHERE ACCOUNT_ID = v_account_id AND AMOUNT > c_threshold_multiplier * v_avg_amount
    ) LOOP
      DBMS_OUTPUT.PUT_LINE('Suspicious Transaction Detected: ' || 
                           'Transaction ID = ' || r.TXN_ID || 
                           ', Amount = ' || r.AMOUNT || 
                           ', Date = ' || r.TXN_DATE || 
                           ', Account ID = ' || v_account_id ||
                           '  v_avg_amount'  || v_avg_amount
                           );
    END LOOP;
  END LOOP;
  CLOSE Account_Cursor;
END;