SET SERVEROUTPUT ON;
DECLARE
V product.PRODUCT_cd%type;
TYPE tab IS TABLE OF product.PRODUCT_cd%type;
   data tab;
BEGIN
SELECT PRODUCT_CD bulk collect  INTO data FROM PRODUCT;
FOR i IN data.FIRST .. data.LAST LOOP
      DBMS_OUTPUT.PUT_LINE('Element ' || i || ': ' || data(i));
   END LOOP;

END;
/