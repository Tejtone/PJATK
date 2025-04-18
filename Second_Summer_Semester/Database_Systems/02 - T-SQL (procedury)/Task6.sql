-- twórz procedurę umożliwiającą wstawianie nowych pracowników do tabeli EMP. W parametrach 
-- podaj: 
-- ● nazwa działu 
-- ● nazwisko pracownika 
-- Przed wprowadzeniem nowego rekordu procedura powinna sprawdzić, czy istnieje dokładnie jeden 
-- dział o podanej nazwie (jeśli nie, należy zgłosić błąd). 
-- Znajdź wartości dla pozostałych kolumn: 
-- ● Job - znajdź nazwę stanowiska z największą liczbą pracowników. 
-- ● Sal - oblicz wynagrodzenie równe płacy minimalnej w danym dziale 
-- ● Empno - bieżące maksymalne empno + 1 
-- ● Deptno - identyfikator działu o nazwie podanej w parametrze 

CREATE PROCEDURE Task6
    @dname VARCHAR(30),
    @ename VARCHAR(40)
AS
BEGIN
    DECLARE @deptCount INT,
            @deptno INT,
            @empno INT,
            @job VARCHAR(20),
            @sal INT;

    SELECT @deptCount = COUNT(*) FROM DEPT WHERE dname = @dname;

    IF @deptCount != 1
    BEGIN
        THROW 51000, 'Błąd: dział o tej nazwie nie istnieje lub istnieje wiele', 1;
    END;

    SELECT @deptno = deptno FROM DEPT WHERE dname = @dname;

    SELECT @empno = MAX(empno) + 1 FROM EMP;

    SELECT TOP 1 @job = job
    FROM EMP
    GROUP BY job
    ORDER BY COUNT(*) DESC;

    SELECT @sal = MIN(sal)
    FROM EMP
    WHERE deptno = @deptno;

    INSERT INTO EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)
    VALUES (@empno, @ename, @job, NULL, GETDATE(), @sal, NULL, @deptno);

    PRINT 'Nowy pracownik został dodany: ' + @ename + ', empno: ' + CONVERT(VARCHAR, @empno);
END;

EXEC Task6 @dname = 'SALES', @ename = 'NOWAK';
