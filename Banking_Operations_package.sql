CREATE OR REPLACE PACKAGE Banking_Operations AS
    -- Ajoute un nouveau client à la base de données
    PROCEDURE Add_Customer(
        p_cust_id IN CUSTOMER.CUST_ID%TYPE,
        p_address IN CUSTOMER.ADDRESS%TYPE,
        p_city IN CUSTOMER.CITY%TYPE,
        p_cust_type_cd IN CUSTOMER.CUST_TYPE_CD%TYPE,
        p_fed_id IN CUSTOMER.FED_ID%TYPE,
        p_postal_code IN CUSTOMER.POSTAL_CODE%TYPE,
        p_state IN CUSTOMER.STATE%TYPE
    );

    -- Supprime un client de la base de données
    PROCEDURE Delete_Customer(
        p_cust_id IN CUSTOMER.CUST_ID%TYPE
    );

    -- Met à jour l'adresse d'un client existant
    PROCEDURE Update_Customer_Address(
        p_cust_id IN CUSTOMER.CUST_ID%TYPE,
        p_new_address IN CUSTOMER.ADDRESS%TYPE,
        p_new_city IN CUSTOMER.CITY%TYPE,
        p_new_postal_code IN CUSTOMER.POSTAL_CODE%TYPE,
        p_new_state IN CUSTOMER.STATE%TYPE
    );
END Banking_Operations;
