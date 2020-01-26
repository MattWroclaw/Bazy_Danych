-- Pytania z rozmowy rekrutacyjnej

-- 1) Co to jest klucz główny (primary key)
-- 2) Co to jest klucz obcy (foreign key)
-- 3) Czym się różni UNQUE od PRIMARY KEY ?
-- 4) Po co stosujemy indeksy bazodanowe?
-- 5) Jakie są nieprzyjemne skutki dodawania indeksów do tabel?
-- 6) Jaka jest różnica między DELETE a TRUNCATE ?
-- 7) Podać przykłady typów ograniczeń (constraint) ?
-- 8) Podaj przykład funkcji agregującej?
-- 9) Czym się różni INNER JOIN od LEFT JOIN
-- 10) Jak w SQL usuwa się duplikaty wierszy?
-- 11) Jeśli chcemy porównąć w WHERE kolumne do wzorca np A% to jak to robimy?
-- 12) Co to jest tranzakcja? Co ją charakteryzuje?

-- Proszę naprawić / zmodyfikować następujące zapytania

-- Na początek coś łatwego, jest błąd co jest nie tak
SELECT imie, nazwisko FROM pasazer 

-- Chciałbym policzyć ilość wierszy które jest w tablicy pasażer.
-- Gdzie jest bład w tym zapytaniu?
SELECT SUM(id) FROM pasazer


-- ) Chciałbym sprawdzić czy w tabeli pasażer jest wiersz gdzie pole nazwisko 
-- ustawione jest na null. Co jest nie tak z poniższym zapytaniem
SELECT * FROM pasazer WHERE nazwisko=null   -- is null

-- ) Zapytanie wyświetla pasażerów  w losowej kolejnosci a chcemy 
-- żeby była w kolejności alfabetycznej, mowa o nazwisku i imieniu
SELECT * FROM pasazer -- order by nazwisko ,imie

-- ) Chciałbym wyświetlić ilość bramek dla każdego z portów, czego brakuje na końcu
SELECT nazwa_portu, count(*) FROM numer_stanowiska ........ -- group by nazwa portu

-- ) 
SELECT * FROM  kontrola JOIN numer_stanowiska n ON  

-- ) Wyświetlenie informacje o kontrolach dla wszystkich pasażerów (również tych którzy
-- nie mieli ani jednej kontroli). Zapytanie powinno zwrócić 17 wierszy.

SELECT * FROM pasazer p JOIN kontrola k ON p.id=k.id_pasazer  -- lesft join
SELECT * FROM pasazer p LEFT JOIN kontrola k ON p.id=k.id_pasazer 


-- ) Dlaczego poniższe pytanie zwraca błąd? Spróbuj naprawić zapytanie.
SELECT * FROM kontrola JOIN numer_stanowiska ON id_numer_stanowiska=id
JOIN pasazer ON id_pasazer=id --k.id_numer_stanowiska = ns.id

-- Chciałbym wyświetlić strażników, którzy mieli więcej niż jedną przeprowadzoną 
-- kontrolę niestety w pytaniu jest błąd, popraw zapytanie?
SELECT id, imie, nazwisko,count(*) AS liczba_kontroli FROM kontrola k JOIN straznik s 
ON k.id_straznik=s.id GROUP BY id, imie, nazwisko WHERE liczba_kontroli>1
-- zamiast WHERE having liczba_kontorli>1
