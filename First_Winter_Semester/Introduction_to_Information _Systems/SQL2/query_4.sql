SELECT DEPTNO FROM EMP;
SELECT DEPTNO FROM DEPT;

-- Zwraca numery działów przypisane każdemu pracownikowi w tabeli EMP
-- Zwraca numery działów, które są zapisane w tabeli DEPT

SELECT DISTINCT DEPTNO FROM EMP;
SELECT DEPTNO FROM DEPT;

-- Dodanie klauzuli DISTINCT powoduje, że wynik zapytania będzie zawierał tylko unikalne numery działów w tabeli EMP, bez powtórzeń
-- Porównanie wyników tych dwóch zapytań ujawnia, że wynik z tabeli EMP różni się od tego z tabeli DEPT, ponieważ w tabeli EMP nie ma działu o numerze 40
