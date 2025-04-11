-- Napisz prosty program w języku Transact-SQL. Zadeklaruj zmienną, przypisz do niej liczbę rekordów 
-- w tabeli Emp i wydrukuj wynik za pomocą instrukcji PRINT - na przykład "Jest 10 pracowników”. 

    DECLARE @liczba_pracowników INT;
    SELECT @liczba_pracowników = COUNT(*)
    FROM emp;

    PRINT ' Jest ' + CONVERT(VARCHAR, @liczba_pracownikow) + ' pracowników '
