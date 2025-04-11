-- Utwórz trigger zapobiegający usuwaniu rekordów z tabeli EMP

    CREATE TRIGGER Task2 ON EMP
        INSTEAD OF DELETE
        AS
        BEGIN
            RAISERROR ('Usuwanie z EMP jest zablokowane!', 17, 1);
        END;

DELETE FROM EMP WHERE empno = 7369;
