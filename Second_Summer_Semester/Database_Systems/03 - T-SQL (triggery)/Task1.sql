-- Utwórz wyzwalacz, który:
-- ● Sprawdzi, czy pensja dodanego pracownika jest wyższa niż 1000. Jeśli nie, powinna zostać
-- zaktualizowana do 1000. W tym przypadku powinna zostać wyświetlona informacja, że
-- pensja została zmieniona
-- ● Wyświetli błąd, jeśli spróbujesz usunąć pracownika, którego numer jest większy niż
-- minimalny numer departamentu
-- ● Sprawdzi, czy zaktualizowana data zatrudnienia pracownika jest w przyszłości. Jeśli tak,
-- należy zaktualizować ją do dzisiejszej daty.

CREATE TRIGGER Task1 ON emp
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    IF EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        UPDATE emp
        SET sal = 1000
        WHERE empno IN (
            SELECT empno
            FROM inserted
            WHERE sal < 1000
        );

        PRINT 'Pensje zostały zmienione';
    END

    -- DELETE
    IF EXISTS(SELECT * FROM deleted) AND NOT EXISTS(SELECT * FROM inserted)
    BEGIN
        DECLARE @minDeptno INT;
        SELECT @minDeptno = MIN(deptno) FROM dept;

        IF EXISTS(SELECT * FROM deleted WHERE empno < @minDeptno)
        BEGIN
            RAISERROR('Próba usunięcia nieprawidłowego pracownika', 10, 1);

            INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
            FROM deleted
            WHERE empno < @minDeptno;
        END;
    END

    -- UPDATE
    IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
    BEGIN
        UPDATE emp
        SET hiredate = SYSDATETIME()
        WHERE empno IN (
            SELECT empno
            FROM inserted
            WHERE hiredate > SYSDATETIME()
        );
    END
END;

SELECT * FROM emp;

INSERT INTO emp (empno, ename, job, hiredate, sal, deptno)
VALUES (200, 'TEST', 'JOB', '2024-05-05', 800, 10);

DELETE emp
WHERE empno = 200;

UPDATE emp
SET hiredate = '2025-05-05'
WHERE empno = 200;
