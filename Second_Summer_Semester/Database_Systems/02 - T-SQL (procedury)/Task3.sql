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
