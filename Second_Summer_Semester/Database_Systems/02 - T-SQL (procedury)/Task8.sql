CREATE PROCEDURE Task8
    @empno INT
AS
BEGIN
    DECLARE
        @ename VARCHAR(20),
        @job VARCHAR(20),
        @deptno INT,
        @sal DECIMAL(10, 2),
        @comm DECIMAL(10, 2),
        @avg_sal DECIMAL(10, 2),
        @bonus DECIMAL(10, 2) = 0;

    IF NOT EXISTS (SELECT 1 FROM EMP WHERE empno = @empno)
    BEGIN
        THROW 51000, 'Błąd: pracownik o podanym empno nie istnieje.', 1;
    END;

    SELECT
        @ename = ename,
        @job = job,
        @deptno = deptno,
        @sal = sal,
        @comm = comm
    FROM EMP
    WHERE empno = @empno;

    IF @sal IS NULL
    BEGIN
        THROW 51000, 'Błąd: pracownik nie ma wynagrodzenia.', 1;
    END;

    IF @job = 'MANAGER'
        SET @bonus = @sal * 0.15;
    ELSE IF @job = 'ANALYST'
        SET @bonus = @sal * 0.12;
    ELSE IF @job = 'SALESMAN'
        SET @bonus = @sal * 0.10 + ISNULL(@comm, 0) * 0.05;
    ELSE
        SET @bonus = @sal * 0.08;

    SELECT @avg_sal = AVG(sal * 1.0)
    FROM EMP
    WHERE deptno = @deptno;

    IF @avg_sal > 3000
        SET @bonus = @bonus + (@sal * 0.05);

    INSERT INTO BONUS_HISTORY (EMPNO, ENAME, JOB, DEPTNO, SAL, COMM, BONUS_AMOUNT, BONUS_DATE)
    VALUES (@empno, @ename, @job, @deptno, @sal, @comm, @bonus, GETDATE());

    PRINT 'Premia została przydzielona pracownikowi ' + @ename + ' (empno: ' + CONVERT(VARCHAR, @empno) + ').';
END;

EXEC Task8 @empno = 7839;
