-- Przekształć kod z poprzedniego zadania w procedurę, aby wartości zarobków (1000 i 1500) były 
-- dostarczane jako parametry wejściowe procedury.

CREATE PROCEDURE task5
    @minSalary INT,
    @maxSalary INT
AS
BEGIN
DECLARE all_ename CURSOR FOR
SELECT empno, ename, sal FROM EMP;

DECLARE @empno INT, @ename VARCHAR(20), @sal INT;

OPEN all_ename;

FETCH NEXT FROM all_ename INTO @empno, @ename, @sal;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @sal < @minSalary
    BEGIN
        UPDATE EMP
        SET sal = sal * 1.1
        WHERE empno = @empno;

        PRINT @ename + ' miał pensję poniżej ' + CONVERT(VARCHAR, @minSalary) + ' – nowa pensja: ' +
              CONVERT(VARCHAR, @sal * 1.1);
    END;
    ELSE IF @sal > @maxSalary
    BEGIN
        UPDATE EMP
        SET sal = sal * 0.9
        WHERE empno = @empno;

        PRINT @ename + ' miał pensję powyżej ' + CONVERT(VARCHAR, @maxSalary) +  '– nowa pensja: ' +
              CONVERT(VARCHAR, @sal * 0.9);
    END;

    FETCH NEXT FROM all_ename INTO @empno, @ename, @sal;
END;

CLOSE all_ename;
DEALLOCATE all_ename;
END;

EXEC task5 @minSalary = 1000, @maxSalary = 1500;
