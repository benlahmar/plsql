BEGIN
    -- Appel à la procédure pour ajouter un client
    Banking_Operations.Add_Customer(
        p_cust_id => 1001,
        p_address => '123 maarif Street',
        p_city => 'casa',
        p_cust_type_cd => 'R',
        p_fed_id => '999-99-9999',
        p_postal_code => '90210',
        p_state => 'MA'
    );
    
    -- Appel à la procédure pour supprimer un client
    Banking_Operations.Delete_Customer(
        p_cust_id => 1002
    );
    
    -- Appel à la procédure pour mettre à jour l'adresse d'un client
    Banking_Operations.Update_Customer_Address(
        p_cust_id => 1003,
        p_new_address => '456 Oak Avenue',
        p_new_city => 'Othertown',
        p_new_postal_code => '90310',
        p_new_state => 'CA'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
