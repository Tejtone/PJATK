-- Utwórz procedurę, która znajdzie liczbę pracowników dla każdego działu. Jeśli liczba ta będzie niższa 
-- od podanej, wyświetl następujący komunikat: "Dział numer X ma Y pracowników". Na końcu procedury 
-- wyświetl informację o liczbie wyświetlonych komunikatów, a jeśli liczba jest niższa niż liczba 
-- wszystkich działów, daj podwyżkę osobie o nazwie "KING". 

CREATE PROCEDURE Task1
    @number INT
AS
    
BEGIN

        DECLARE @mssgCount INT = 0, @deptCount INT;

        SELECT @deptCount = COUNT(*)
        FROM dept;

        DECLARE curl CURSOR FOR SELECT deptno, COUNT(*) FROM emp GROUP BY deptno;
        DECLARE @deptno INT, @count INt;

        OPEN curl;
        FETCH NEXT FROM curl INTO @deptno, @count;

        WHILE @@FETCH_STATUS = 0
        BEGIN

            IF @count < @number
            BEGIN

                PRINT 'Dział numer ' + CONVERT(VARCHAR, @deptno) + ' ma ' + CONVERT(VARCHAR, @count) + ' liczbę pracowników ';
                SET @mssgCount = @mssgCount + 1;

            END;

            FETCH NEXT FROM curl INTO @deptno, @count;
        END;

        CLOSE curl;
        DEALLOCATE curl;

        PRINT 'komunikaty = ' + CONVERT(VARCHAR, @mssgCount);

        IF @mssgCount < @deptCount
        BEGIN

            UPDATE emp
            SET sal = sal + 100
            WHERE ename = 'KING';

        END;

END;




EXEC Task1 @number = 4;
