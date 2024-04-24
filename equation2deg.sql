DECLARE
a  number(4,2);
b number(4,2);
c number(4,2);
delta number(4,2);
x1 number(4,2);
x2 number(4,2);
BEGIN
    a:= :a;-- instead of "&" use ":" here 
    b:= :b;
    c:= :c;
delta  := b*b -4*a*c;
IF(delta<0) THEN
    dbms_output.put_line('pas de solution en R');
ELSIF (delta=0) THEN
    x1:= -b/2*a;
     dbms_output.put_line('x=' || x1);
ELSE
    x1:= (-b-SQRT(delta))/2*a;
    x2:= (-b+SQRT(delta))/2*a;
     dbms_output.put_line('x1=' || x1 || '  x2= '|| x2);
END IF;

End;