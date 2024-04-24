CREATE OR REPLACE PACKAGE BODY Banking_Operations AS

    PROCEDURE Add_Customer(
        p_cust_id IN CUSTOMER.CUST_ID%TYPE,
        p_address IN CUSTOMER.ADDRESS%TYPE,
        p_city IN CUSTOMER.CITY%TYPE,
        p_cust_type_cd IN CUSTOMER.CUST_TYPE_CD%TYPE,
        p_fed_id IN CUSTOMER.FED_ID%TYPE,
        p_postal_code IN CUSTOMER.POSTAL_CODE%TYPE,
        p_state IN CUSTOMER.STATE%TYPE
    ) IS
    BEGIN
        INSERT INTO CUSTOMER (CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FED_ID, POSTAL_CODE, STATE)
        VALUES (p_cust_id, p_address, p_city, p_cust_type_cd, p_fed_id, p_postal_code, p_state);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Failed to add customer: ' || SQLERRM);
    END Add_Customer;

    PROCEDURE Delete_Customer(
        p_cust_id IN CUSTOMER.CUST_ID%TYPE
    ) IS
    BEGIN
        DELETE FROM CUSTOMER WHERE CUST_ID = p_cust_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Failed to delete customer: ' || SQLERRM);
    END Delete_Customer;

    PROCEDURE Update_Customer_Address(
        p_cust_id IN CUSTOMER.CUST_ID%TYPE,
        p_new_address IN CUSTOMER.ADDRESS%TYPE,
        p_new_city IN CUSTOMER.CITY%TYPE,
        p_new_postal_code IN CUSTOMER.POSTAL_CODE%TYPE,
        p_new_state IN CUSTOMER.STATE%TYPE
    ) IS
    BEGIN
        UPDATE CUSTOMER
        SET ADDRESS = p_new_address, CITY = p_new_city, POSTAL_CODE = p_new_postal_code, STATE = p_new_state
        WHERE CUST_ID = p_cust_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Failed to update customer address: ' || SQLERRM);
    END Update_Customer_Address;

END Banking_Operations;
