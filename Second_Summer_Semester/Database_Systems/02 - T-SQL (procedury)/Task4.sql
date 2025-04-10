DECLARE all_ename CURSOR FOR
SELECT empno, ename, sal FROM EMP;

DECLARE @empno INT, @ename VARCHAR(20), @sal INT;

OPEN all_ename;

FETCH NEXT FROM all_ename INTO @empno, @ename, @sal;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @sal < 1000
    BEGIN
        UPDATE EMP
        SET sal = sal * 1.1
        WHERE empno = @empno;

        PRINT @ename + ' miał pensję poniżej 1000 – nowa pensja: ' +
              CONVERT(VARCHAR, @sal * 1.1);
    END
    ELSE IF @sal > 1500
    BEGIN
        UPDATE EMP
        SET sal = sal * 0.9
        WHERE empno = @empno;

        PRINT @ename + ' miał pensję powyżej 1500 – nowa pensja: ' +
              CONVERT(VARCHAR, @sal * 0.9);
    END

    FETCH NEXT FROM all_ename INTO @empno, @ename, @sal;
END

CLOSE all_ename;
DEALLOCATE all_ename;

SELECT empno, ename, sal FROM EMP ORDER BY empno;
