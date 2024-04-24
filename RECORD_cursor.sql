DECLARE
    TYPE r_customer_type IS RECORD(
        customer_name customers.name%TYPE,
        credit_limit customers.credit_limit%TYPE
    ); 

    TYPE t_customer_type IS VARRAY(5) 
        OF r_customer_type;
    
    t_customers t_customer_type := t_customer_type();

    CURSOR c_customer IS 
        SELECT NAME, credit_limit 
        FROM customers 
        ORDER BY credit_limit DESC 
        FETCH FIRST 5 ROWS ONLY;
BEGIN
    -- fetch data from a cursor
    FOR r_customer IN c_customer LOOP
        t_customers.EXTEND;
        t_customers(t_customers.LAST).customer_name := r_customer.name;
        t_customers(t_customers.LAST).credit_limit  := r_customer.credit_limit;
    END LOOP;

    -- show all customers
    FOR l_index IN t_customers .FIRST..t_customers.LAST 
    LOOP
        dbms_output.put_line(
            'The customer ' ||
            t_customers(l_index).customer_name ||
            ' has a credit of ' ||
            t_customers(l_index).credit_limit
        );
    END LOOP;

END;
/
