/*Concevez une procédure qui transfère un montant spécifié d'un compte à un autre, 
en vérifiant que les deux comptes sont actifs avant de réaliser le transfert
*/
CREATE OR REPLACE PROCEDURE transfert2comte
   (id_acc1 IN number, id_acc2 IN number, mnt IN NUMBER) 
      IS
          bal1 NUMBER;
          bal2 NUMBER;
          status1 account.status%type;
          status2 account.status%type;
      BEGIN
         
        SELECT  avail_balance, status INTO bal1,status1 FROM account where account_id=id_acc1 ; 
        SELECT  avail_balance, status INTO bal2,status2 FROM account where account_id=id_acc2 ; 
        
        IF status1='ACTIVE' and status2='ACTIVE' THEN
           IF  bal1 < mnt THEN
            DBMS_OUTPUT.PUT_LINE('solde insuffisant');
           ELSE
            UPDATE account set avail_balance=bal1-mnt where account_id=id_acc1 ; 
            UPDATE account set avail_balance=bal2+mnt where account_id=id_acc2 ; 
            DBMS_OUTPUT.PUT_LINE('transfert effectué');
            COMMIT;  
           end if;
        ELSE
        DBMS_OUTPUT.PUT_LINE('compte non active');
        end if;
    
      END transfert2comte;
      /

SET SERVEROUTPUT ON;
EXEC transfert2comte(1,2,4444440);

SELECT * FROM account;