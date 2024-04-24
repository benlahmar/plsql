/*

2.	Écrivez une procedure qui ''retourne'' une collection contenant les ID des comptes 
qui ont une balance disponible supérieure à un montant spécifié par l'utilisateur.

gerer les exception utils

avec l'historique des transaction entre deux dates
*/

CREATE or replace PROCEDURE relever
       (acc_id account.account_id%type, seuil account.avail_balance%type, data OUT dd  ) 
      IS
          ic  account.account_id%type;
          cursor acc_cursor           
          is
            select account_id from account where avail_balance > seuil;
      BEGIN
            data := dd();
          open acc_cursor;
          loop
          exit when acc_cursor%notfound;
            fetch acc_cursor into ic ;
            
           
           data.extend;
           data(data.last) := ic;
          end loop;
          close acc_cursor;
      END relever;



DECLARE

d dd;
begin

relever(3,334567,d);
for i in d.first .. d.last loop
dbms_output.put_line(d(i)); 
end loop;
end;
      