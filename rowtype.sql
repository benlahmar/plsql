SET SERVEROUTPUT ON;
DECLARE
v product%rowtype;
BEGIN
select * into v from PRODUct where product_cd='AUT';
-- afficher les données du record
    dbms_output.put_line('Nom : '|| v.name); 
    dbms_output.put_line('CD : '|| v.product_cd);
    dbms_output.put_line('Type CD : '|| v.product_type_cd);

END;
