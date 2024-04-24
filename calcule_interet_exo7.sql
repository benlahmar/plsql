/*
Écrivez une fonction qui calcule l'intérêt cumulé pour un compte donné 
sur une période spécifiée par l'utilisateur en utilisant un taux d'intérêt composé
*/

CREATE OR REPLACE FUNCTION Calculate_Interest(
    p_interest_rate IN NUMBER, acc_id IN int, p_years IN number
) RETURN NUMBER IS

som NUMBER;

v_initial_balance account.avail_balance%type;


BEGIN
SELECT avail_balance into v_initial_balance FROM account where account_id=acc_id  ;
-- Calcul de l'intérêt composé
    som := v_initial_balance * POWER(1 + p_interest_rate / 100, p_years) - v_initial_balance;

    -- Retourner le montant de l'intérêt composé
    RETURN som;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL; -- Retourner NULL si aucun compte n'est trouvé
    WHEN OTHERS THEN
        RAISE; -- Propager les autres exceptions
END Calculate_Interest;
/

SET SERVEROUTPUT ON; 
DECLARE
    v_interest NUMBER;
BEGIN
    v_interest := Calculate_Interest(acc_id => 1, p_interest_rate => 5, p_years => 3);
    DBMS_OUTPUT.PUT_LINE('Calculated Compound Interest: ' || TO_CHAR(v_interest, 'FM999G999G999G990D00'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error calculating interest: ' || SQLERRM);
END;
