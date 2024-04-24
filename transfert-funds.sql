CREATE OR REPLACE PROCEDURE Transfer_Funds(
    p_from_account_id IN ACCOUNT.ACCOUNT_ID%TYPE,
    p_to_account_id IN ACCOUNT.ACCOUNT_ID%TYPE,
    p_amount IN NUMBER
) IS
    v_from_balance NUMBER;
    v_to_balance NUMBER;
    v_from_status ACCOUNT.STATUS%TYPE;
    v_to_status ACCOUNT.STATUS%TYPE;
BEGIN
    -- Vérifier que les deux comptes sont actifs
    SELECT AVAIL_BALANCE, STATUS INTO v_from_balance, v_from_status
    FROM ACCOUNT WHERE ACCOUNT_ID = p_from_account_id;
    
    SELECT AVAIL_BALANCE, STATUS INTO v_to_balance, v_to_status
    FROM ACCOUNT WHERE ACCOUNT_ID = p_to_account_id;

    IF v_from_status != 'Active' OR v_to_status != 'Active' THEN
        RAISE_APPLICATION_ERROR(-20001, 'One or both accounts are not active.');
    END IF;
    
    -- Vérifier que le solde du compte expéditeur est suffisant
    IF v_from_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20002, 'Insufficient funds in the from account.');
    END IF;
    
    -- Effectuer le transfert
    UPDATE ACCOUNT SET AVAIL_BALANCE = v_from_balance - p_amount
    WHERE ACCOUNT_ID = p_from_account_id;
    
    UPDATE ACCOUNT SET AVAIL_BALANCE = v_to_balance + p_amount
    WHERE ACCOUNT_ID = p_to_account_id;

    -- Ajouter un enregistrement de transaction (à adapter selon votre gestion des transactions)
   /* INSERT INTO ACC_TRANSACTION (TXN_ID, AMOUNT, TXN_DATE, TXN_TYPE_CD, ACCOUNT_ID)
    VALUES (SEQ_TRANSACTION.NEXTVAL, p_amount, SYSDATE, 'Transfer', p_from_account_id);
    
    INSERT INTO ACC_TRANSACTION (TXN_ID, AMOUNT, TXN_DATE, TXN_TYPE_CD, ACCOUNT_ID)
    VALUES (SEQ_TRANSACTION.NEXTVAL, p_amount, SYSDATE, 'Receive', p_to_account_id);
*/
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Account not found.');
    WHEN OTHERS THEN
        RAISE;
END Transfer_Funds;
/



BEGIN
    Transfer_Funds(p_from_account_id => 101, p_to_account_id => 102, p_amount => 500);
    DBMS_OUTPUT.PUT_LINE('Transfer successful.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error during transfer: ' || SQLERRM);
END;


exec Transfer_Funds(p_from_account_id => 101, p_to_account_id => 102, p_amount => 500);