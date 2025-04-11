-- Utwórz procedurę do wstawiania nowych działów. Procedura będzie przyjmowała jako parametry 
-- nazwy i lokalizacji. Numer działu zostanie wygenerowany automatycznie i zwrócony w parametrze 
-- wyjściowym. Procedura powinna sprawdzić, czy dział o podanej nazwie lub lokalizacji już istnieje. Jeśli 
-- tak, nie wstawi nowego rekordu i zgłosi błąd. 

CREATE PROCEDURE task3
    @dname VARCHAR(50),
    @loc VARCHAR(20),
    @dnumber INT OUTPUT
AS
BEGIN
    DECLARE @newDeptno INT;

    IF EXISTS (SELECT 1 FROM DEPT WHERE dname = @dname OR loc = @loc)
    BEGIN
        THROW 51000, 'Podana nazwa lub lokalizacja istnieje', 1;
    END;

    SELECT @newDeptno = MAX(deptno) + 10 FROM DEPT;
    INSERT INTO DEPT (deptno, dname, loc)
    VALUES (@newDeptno, @dname, @loc);
    SET @dnumber = @newDeptno;
END;

DECLARE @dout INT;
EXEC task3 @dname = 'HR', @loc = 'Kraków', @dnumber = @dout OUTPUT;
PRINT 'Nowy numer działu: ' + CONVERT(VARCHAR, @dout);
