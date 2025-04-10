    DECLARE @liczba_pracowników INT;
    SELECT @liczba_pracowników =  COUNT(*)
    FROM emp;

    PRINT ' Jest ' + CONVERT(VARCHAR, @liczba_pracownikow) + ' pracowników '
