set SERVEROUTPUT on
DECLARE

total number;
temp number;
xx number;
res transaction_analysis.txn_customer;
begin
TRANSACTION_ANALYSIS.total_transaction(1, total);
dbms_output.put_line('------'||total);
temp := transaction_analysis.avg_transaction_employee(2);
dbms_output.put_line('--totale emp----'||temp);


transaction_analysis.Totale_Transaction_Customer(1, res);

for i in res.first .. res.last loop
dbms_output.put_line(res(i).idcpt||'  ---  '||res(i).totale);
end loop;
end;


select count(*)  from acc_transaction where teller_emp_id=2;


select sum(trx.amount),acc.account_id from acc_transaction trx , Account acc  where trx.account_id=acc.account_id and acc.cust_id=1 GROUP by acc.account_id;
