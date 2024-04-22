/*
Écrire un script PL/SQL qui recuper l'ID du compte, le solde disponible et le statut
dans un table et afficher ce table 
*/
set SERVEROUTPUT  ON
        DECLARE  
        --declaration  d'untype 
      TYPE accounttab is TABLE of account.avail_balance%type;     
        --declaration du table
        tab1 accounttab ;
        
        cursor account_curs IS
        select avail_balance
        from account;
        
        bal account.avail_balance%type;
        BEGIN 
        tab1 := accounttab();
        open account_curs;
        LOOP
         FETCH account_curs into bal ;
         exit WHEN account_curs%notfound; 
        tab1.extend;
        tab1(tab1.last) :=bal;
        end loop;
        close account_curs;
      -- affichage du tab
      for i in tab1.first .. tab1.last loop
      
      dbms_output.put_line('bal   '|| tab1(i));
      end loop;
      
        END;
