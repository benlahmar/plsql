/*
2.	Écrivez une fonction qui retourne une collection contenant les ID des comptes 
qui ont une balance disponible supérieure à un montant spécifié par l'utilisateur.
*/
SET SERVEROUTPUT ON;
DECLARE
Cursor balance_cursor is 
select account_id,avail_balance from account WHERE avail_balance>3000;
type tabtype is table of account.account_id%type;
i int :=1;
tab tabtype;
acc_id account.account_id%type;
avail account.avail_balance%type;
begin
tab:=tabtype();
open balance_cursor;
loop
fetch balance_cursor into acc_id,avail;
exit when balance_cursor%notfound;
tab.extend;
tab(i) := acc_id;
i := i+1;
end loop;

close balance_cursor;

for j in 1 .. tab.count loop
DBMS_OUTPUT.PUT_LINE('id:  '||tab(j));
end loop;

IF tab.COUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No business addresses found.');
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);

end;