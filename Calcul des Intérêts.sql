--calcule les intérêts pour chaque compte  taux d'interet
SET SERVEROUTPUT ON;
DECLARE
CURSOR compte_cursor  IS
SELECT account_id, avail_balance FROM account;
acc_id account.account_id%TYPE;
taux NUMBER(2,2);
solde account.avail_balance%TYPE;
interet FLOAT := 3.4;

BEGIN

OPEN compte_cursor;

loop

FETCH compte_cursor INTO acc_id, solde;
exit WHEN compte_cursor%notfound;

DBMS_OUTPUT.PUT_LINE('solde interet de '||acc_id||' est  :'||solde*interet);
end loop;
close compte_cursor;

End;