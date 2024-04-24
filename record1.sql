SET SERVEROUTPUT ON;
DECLARE
    -- autres déclarations
    TYPE Personne IS RECORD ( 
        Id NUMBER ,
        Nom  VARCHAR(30), 
        Age NUMBER,
        Departement VARCHAR(30)
    );
    p1 Personne; -- une variable de type personne
 

    -- autres déclarations
BEGIN
    -- Initialiser le record p1
    p1:=personne();
    p1.Id :=1;
    p1.Nom:='habib';
    p1.Age:=27;
    p1.Departement:='Informatique';
 
    -- Afficher les informations de la personne p1
        dbms_output.put_line('ID : '|| p1.Id); 
        dbms_output.put_line('Nom : '|| p1.Nom); 
        dbms_output.put_line('Age : '|| p1.Age); 
        dbms_output.put_line('Departement : '|| p1.Departement); 
END;