-- Utwórz wyzwalacz, który w przypadku wstawienia lub modyfikacji danych w tabeli EMP sprawdzi, czy
-- nowe zarobki (wstawione lub zmodyfikowane) są większe niż 1000. W przeciwnym razie wyzwalacz
-- powinien zgłosić błąd i uniemożliwić wstawienie rekordu.
-- Uwaga: Ten sam efekt można łatwiej uzyskać przy użyciu ograniczeń spójności CHECK. Użyjmy
-- triggera do celów szkoleniowych.

CREATE TRIGGER T3
ON EMP
FOR INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Sprawdzenie, czy nowe dane zawierają zarobki <= 1000
    IF EXISTS (
        SELECT 1 FROM inserted WHERE sal <= 1000
    )
    BEGIN
        THROW 51000, 'Zarobki muszą być większe niż 1000!', 1;
    END
END;

INSERT INTO EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (9001, 'JOHN', 'CLERK', 7839, GETDATE(), 800, NULL, 20);
