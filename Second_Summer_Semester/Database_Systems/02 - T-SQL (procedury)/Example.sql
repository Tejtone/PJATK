CREATE PROCEDURE Task1
    @number INT
AS
BEGIN

        DECLARE @mssgCOUNT INT = 0, @deptCount INT;

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
                SET @mssgCOUNT = @mssgCOUNT + 1;

            END;

            FETCH NEXT FROM curl INTO @deptno, @count;
        END;

        CLOSE curl;
        DEALLOCATE curl;

        PRINT 'komunikaty = ' + CONVERT(VARCHAR, @mssgCOUNT);

        IF @mssgCOUNT < @deptCount
        BEGIN

            UPDATE emp
            SET sal = sal + 100
            WHERE ename = 'KING';

        END;

END;

EXEC Task1 @number = 4;
