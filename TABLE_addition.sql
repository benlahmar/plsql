SET SERVEROUTPUT ON;
DECLARE
    TYPE NST_TBL IS TABLE OF NUMBER;
    -- Declare two nested tables 
    var1 NST_TBL := NST_TBL(1, 2);
    var2 NST_TBL := NST_TBL(3, 4);
    --  result nested table
    result NST_TBL;
BEGIN
    result := NST_TBL();
    result.EXTEND(var1.COUNT);
--addition of the elements
    FOR i IN 1..var1.LAST LOOP
        result(i) := var1(i) + var2(i);
    END LOOP;
    -- Display result of addition
    DBMS_OUTPUT.PUT_LINE('Result(1): ' || result(1) || '   Result(2):  ' || result(2));
END;
/