/*
1.	Rapport des Soldes des Comptes: Écrire un script PL/SQL qui génère un rapport des soldes disponibles pour tous les comptes, 
classés par statut du compte. Le rapport doit inclure l'ID du compte, le solde disponible et le statut
*/

 DECLARE   
        balance account.avail_balance%TYPE;
        st1 account.status%type;
        acc_id account.account_id%type;  
        CURSOR account_cur IS
        select * 
        from account  
        ORDER BY status;        
        data account_cur%rowtype;
        BEGIN        
        OPEN account_cur;
        LOOP
        FETCH account_cur INTO data;
        exit when account_cur%notfound;
        dbms_output.put_line(account_cur%rowcount ||'   '|| data.account_id || '  '||data.avail_balance|| '   '||data.status);
        end LOOP;
        CLOSE account_cur;        
        END;
