/*
4.	D�tection des Fraudes: �crire un script qui d�tecte les transactions potentiellement
frauduleuses. Une transaction pourrait �tre consid�r�e comme suspecte si le montant est 
extr�mement �lev� par rapport � la moyenne des transactions du compte
*/
set SERVEROUTPUT ON
DECLARE

cursor txn_fraud IS
select amount, account_id from acc_transaction;

moy NUMBER;
taux FLOAT :=0.2;
BEGIN

for record1 in txn_fraud LOOP

select avg(amount)into moy from acc_transaction where account_id=record1.account_id;

--dbms_output.put_line(record1.amount|| '  ' || moy);
IF record1.amount > moy+moy*taux THEN
dbms_output.put_line('fraud' || record1.amount|| '  ' || moy);
end if;
end loop;

End;

select * from acc_transaction;
insert into  acc_transaction values(103,400,SYSDATE,SYSDATE,'CDT',1,null,2);