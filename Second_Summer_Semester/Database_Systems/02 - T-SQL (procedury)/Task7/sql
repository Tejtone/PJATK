CREATE PROCEDURE Task7
    @deptName VARCHAR(30)
AS
BEGIN
    DECLARE @deptno INT;
    DECLARE @avg_sal DECIMAL(10, 2);

    SELECT @deptno = deptno
    FROM DEPT
    WHERE dname = @deptName;

    IF @deptno IS NULL
    BEGIN
        THROW 51000, 'Błąd: dział o podanej nazwie nie istnieje.', 1;
    END;

    SELECT @avg_sal = AVG(sal * 1.0)
    FROM EMP
    WHERE deptno = @deptno;

    UPDATE EMP
    SET comm = sal * 0.05
    WHERE deptno = @deptno AND sal < @avg_sal;

    PRINT 'Prowizje zostały przydzielone pracownikom zarabiającym poniżej średniej w dziale: ' + @deptName;
END;

EXEC Task7 @deptName = 'SALES';
