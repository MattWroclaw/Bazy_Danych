-- ========== 2.1 NULL ===========
-- recenzje niepowiazane z książką (błędne wiersze)
SELECT * FROM recenzja  WHERE ksiazka_id IS NULL;

-- wszystkie recenzje gdzie jest ustawione id ksiazki
SELECT * FROM recenzja  WHERE ksiazka_id IS NOT NULL;

-- ============= 2.1 Ostrożnie z NULL ==============
SELECT * FROM recenzja;  -- 7 recenzji 

UPDATE recenzja SET ksiazka_id=NULL WHERE recenzja_id=1;

SELECT count(distinct ksiazka_id) FROM recenzja;  -- 5
SELECT count(distinct ksiazka_id) FROM recenzja WHERE ksiazka_id IS NOT NULL; -- 5. mamy tyle samo wierszy co w poprzednim zapytaniu
SELECT distinct  ksiazka_id FROM recenzja; -- a tu niespodzianka o jeden wiecej wiersz! Count nie zlicza NULL
-- u mnie zlicza...


-- wynik takiego przyrównania jest też nullem
SELECT null =  10; -- daje null
SELECT null = null  -- przyrównanie do NULL zawsze zwraca wartość nieznaną 
SELECT null OR true -- daje 1
SELECT null AND true -- daje null


SELECT * FROM recenzja
-- ================== 2.2 JOIN ================
-- wyświetlenie książek z recenzjami
SELECT * FROM ksiazka k, recenzja r WHERE k.ksiazka_id = r.ksiazka_id;
SELECT k.ksiazka_id, k.tytul FROM ksiazka k, recenzja r WHERE k.ksiazka_id = r.ksiazka_id;

-- równoważne z (po polu ksiazka_id)
SELECT * FROM ksiazka k INNER JOIN  recenzja r ON k.ksiazka_id = r.ksiazka_id; 

-- natural
SELECT * FROM ksiazka k NATURAL JOIN recenzja   ;

-- USING
SELECT * FROM ksiazka k  JOIN recenzja  USING (ksiazka_id);

-- JOIN z dodatkowymi warunkami
SELECT * FROM ksiazka k INNER JOIN  recenzja r ON 
k.ksiazka_id = r.ksiazka_id WHERE min_wiek>3

-- albo, równoważny zapis
SELECT * FROM ksiazka k INNER JOIN  recenzja r 
ON k.ksiazka_id = r.ksiazka_id AND min_wiek>3

-- złączenie może być wielokrotne
SELECT kl.imie, kl.nazwisko, ks.autor_imie, ks.autor_nazwisko, ks.tytul, ok.ocena 
FROM klient kl JOIN ocena_ksiazki ok ON kl.klient_id=ok.klient_id
JOIN ksiazka ks ON ks.ksiazka_id = ok.ksiazka_id;

-- albo
SELECT kl.imie, kl.nazwisko, ks.autor_imie, ks.autor_nazwisko, ks.tytul, 
ok.ocena FROM klient kl NATURAL JOIN ocena_ksiazki ok 
NATURAL JOIN ksiazka ks;

-- Ćwiczenia
-- Wyświetlić recenzje stworzone przez klientów tak żeby były informacje o kliencie i sama treść recenzji
 R:  
 
 SELECT r.recenzja_tekst, k.* FROM  recenzja r JOIN klient k ON r.klient_id=k.klient_id;
 
SELECT kl.imie, r.recenzja_tekst FROM klient kl JOIN recenzja r ON kl.klient_id=r.klient_id;

-- prawidłowo
SELECT k.*, r.recenzja_tekst FROM  klient k JOIN recenzja r ON k.klient_id=r.klient_id;

-- Wyświetlić recenzje klienta ale również żeby była statystykę klienta (tablica ze statystyką) tak żeby były informacje o kliencie w wierszu
R: 
SELECT r.recenzja_tekst, st.liczba_przeczytanych_ksiazek FROM recenzja r JOIN statystyka_klienta st ON r.klient_id = st.klient_id;
  
  -- prawidłowo
  SELECT k.*, r.recenzja_tekst FROM  klient k JOIN recenzja r ON k.klient_id=r.klient_id
  JOIN statystyka_klienta sk ON k.klient_id = sk.klient_id;

  
  
-- ============== 2.3 LEFT/RIGHT
-- Wyswietlenie książek z recenzjami (również tych z brakiem recenzji)
SELECT ksiazka.*, recenzja.*  FROM ksiazka LEFT JOIN recenzja USING (ksiazka_id);

SELECT recenzja.*, ksiazka.* FROM ksiazka left JOIN recenzja USING (ksiazka_id);

-- albo
SELECT ksiazka.*, recenzja.*  FROM recenzja right JOIN ksiazka USING (ksiazka_id);

-- Ćwiczenia
-- Wyświetlić wszystkie recenzje wystawione przez klientów. jeśli klient nie wystawił recenzji to powinnien być wiersz z danymi klienta
SELECT recenzja.recenzja_tekst , klient.nazwisko FROM recenzja  RIGHT JOIN klient USING (klient_id);
R: 
SELECT  klient.*, recenzja.recenzja_tekst FROM klient LEFT JOIN recenzja ON klient.klient_id=recenzja.klient_id;

-- prawidłowo
SELECT * FROM klient k LEFT JOIN recenzja r ON k.klient_id = r.klient_id;


-- ================== 2.4 AGREGUJACE =============
-- wyświetlenie ile jest książek danego autora
SELECT autor_imie,autor_nazwisko,COUNT(*) FROM ksiazka
GROUP BY autor_imie,autor_nazwisko;

SELECT COUNT(nazwisko)  FROM ksiazka 

-- wyświetlenie ile jest książek danego autora, ale wyświetlaj tylko tych autorów którzy mają więcej niż jedną książke
SELECT autor_imie,autor_nazwisko,COUNT(*) FROM ksiazka
GROUP BY autor_imie,autor_nazwisko 
HAVING COUNT(*)>1;

-- średnia wszystkich ocen 
SELECT AVG(ocena) FROM ocena_ksiazki;

-- minimalna ocena 
SELECT MIN(ocena) FROM ocena_ksiazki;

-- maksymalna ocena 
SELECT MAX(ocena) FROM ocena_ksiazki;

-- ćwiczenia
-- wyświetlić ilość książek w dla każdego rodzaju 
R:
SELECT rodzaj, tytul , count(ksiazka_id)
FROM ksiazka
GROUP BY rodzaj;

SELECT  count(ksiazka_id) FROM ksiazka;

-- wyświetlić klientów z informacją o ilości wystawionych ocen
R:
SELECT  k.nazwisko, count(ocena)
FROM klient k, ocena_ksiazki ok 
WHERE k.klient_id=ok.klient_id
 GROUP BY nazwisko;


-- ============ 2.5 SUBQUERY (WHERE) ================
-- Wyświetlenie klientów którzy przeczytali więcej niż 50 książek
SELECT * FROM klient 
WHERE klient_id IN 
     (SELECT  klient_id FROM statystyka_klienta WHERE liczba_przeczytanych_ksiazek>50);

-- inaczej
 SELECT * FROM klient k JOIN statystyka_klienta sk ON k.klient_id=sk.klient_id WHERE (liczba_przeczytanych_ksiazek>50);



-- Wyświetlenie klientów którzy przeczytali więcej niż 50 książek i wystawili chociaż jedną ocenę 
SELECT * FROM klient 
WHERE klient_id IN 
     (SELECT  klient_id FROM statystyka_klienta WHERE liczba_przeczytanych_ksiazek>50)
AND 
  klient_id IN (SELECT klient_id FROM ocena_ksiazki WHERE ocena>5);

-- inaczej





-- ćwiczenia
-- wyświetlić książki które mają przynajmniej jedną recenzje z użyciem subquery
R:
SELECT * FROM ksiazka WHERE ksiazka_id IN (SELECT ksiazka_id FROM recenzja)

-- wyświetlić książkę (jest jedna) które ma recenzję z tekstem 'Świetna!'
R:
SELECT * FROM ksiazka WHERE ksiazka_id=(SELECT ksiazka_id FROM recenzja WHERE recenzja_tekst = 'Świetna!');

-- ============ 2.6 SUBQUERY (w SELECT) ================
-- wyswietlenie dane klienta  i w dodatkowej kolumnie wyswietlenie ilosci przeczytanych ksiazek dla klienta o ID=2 (uzyc subquery)

SELECT *, (SELECT liczba_przeczytanych_ksiazek FROM statystyka_klienta WHERE klient_id=2)  FROM klient where klient_id=2;


-- wyswietlenie dane klienta  i w dodatkowej kolumnie wyswietlenie ilosc wystawionych ocen
SELECT kl.*, kl.klient_id , (SELECT  count(ocena) from ocena_ksiazki ok where ok.klient_id = kl.klient_id /*GROUP BY klient_id */) FROM klient kl, ocena_ksiazki ok WHERE ok.klient_id=kl.klient_id group by kl.klient_id ;



-- ćwiczenia
-- wyświetlić imie,nazwisko autora i tytul a w ostatniej kolumnie ilość wystawionych recenzji (uzyc subquery)
R:
SELECT k.autor_imie, k.autor_nazwisko, k.tytul, 
(SELECT count(r.ksiazka_id) FROM recenzja r WHERE k.ksiazka_id=r.ksiazka_id /* GROUP BY r.ksiazka_id */) 
FROM ksiazka k 
-- WHERE  r.ksiazka_id = k.ksiazka_id GROUP BY k.ksiazka_id;

-- tytuł : ile recenzji 
SELECT k.tytul, count(r.ksiazka_id)  FROM recenzja r, ksiazka k WHERE r.ksiazka_id=k.ksiazka_id group by r.ksiazka_id;

SELECT k.autor_imie, k.autor_nazwisko, k.tytul, (SELECT count(*) FROM  recenzja r WHERE r.ksiazka_id = k.ksiazka_id ) FROM ksiazka k;

-- wyświetlić oceny ksiazki 'Powstanie Warszawskie' (w WHERE ma być wyszukanie po nazwie a nie po ID) 
-- w ostatniej kolumniej maksymalna ocena 

SELECT k.*, ok.ocena, max(ocena) FROM ocena_ksiazki ok , ksiazka k
WHERE k.ksiazka_id = (SELECT ksiazka_id FROM ksiazka WHERE tytul = 'Powstanie Warszawskie')
GROUP BY ok.klient_id;


SELECT *, (SELECT max(ok.ocena) FROM ocena_ksiazki ok WHERE ok.ksiazka_id = k.ksiazka_id)
FROM ksiazka k JOIN ocena_ksiazki ok ON k.ksiazka_id=ok.ksiazka_id
WHERE k.tytul='Powstanie warszawskie';


-- w ostatniej kolumnie maksymalną ocenę jaka dostała książka  (zadanie trudniejsze)
-- czyli 'Powstanie Warszawskie', 5, 10 
R:

-- ================= Ćwiczenia - Podsumowanie SQL ======================

-- === Zadanie 1 ===
-- Przepisać poniższe zapytanie bez LEFT JOIN
SELECT autor_imie, autor_nazwisko,tytul, recenzja_tekst FROM ksiazka LEFT JOIN recenzja USING (ksiazka_id);

SELECT k.autor_imie, k.autor_nazwisko, k.tytul, r.recenzja_tekst FROM ksiazka k, recenzja r WHERE k.ksiazka_id = r.ksiazka_id;


SELECT *, null as recenzja_id, null, null FROM ksiazka

R:

-- a jak to posortować po recenzji
SELECT t.autor_imie FROM (
SELECT autor_imie, autor_nazwisko,tytul, recenzja_tekst  FROM ksiazka k , recenzja r WHERE k.ksiazka_id=r.ksiazka_id
UNION 
SELECT autor_imie, autor_nazwisko,tytul, NULL AS recenzja_tekst  FROM ksiazka k WHERE k.ksiazka_id NOT IN 
(SELECT ksiazka_id FROM recenzja) 
) t GROUP BY recenzja_tekst;

-- === Zadanie Dodatkowe ===
-- A jak przepisać pytanie 
-- SELECT ksiazka.*, recenzja.*  FROM recenzja FULL JOIN ksiazka USING (ksiazka_id) żeby nie było JOIN
R: ?
SELECT ksiazka.*, recenzja.*  FROM recenzja FULL JOIN ksiazka USING (ksiazka_id); -- full join nie dziala w  sql

SELECT ksiazka.*, recenzja.* FROM recenzja INNER JOIN ksiazka ON (ksiazka.ksiazka_id);

SELECT ksiazka.*, recenzja.* FROM ksiazka, recenzja WHERE ksiazka.ksiazka_id=recenzja.ksiazka_id;

-- === Zadanie 2 (nauka rozbudowy zapytania SQL) === 
-- Wyświetlić przy każdej książce średnią ocenę dla danej książki z 
-- informacją ile  było ocen
R: 
SELECT k.tytul, avg(ok.ocena) , count(ok.ocena)from ksiazka k, ocena_ksiazki ok where k.ksiazka_id = ok.ksiazka_id GROUP BY ok.ksiazka_id;

-- Wyświetlić średnią ocenę wszystkich książek
R: 
SELECT AVG(ocena) AS 'Średnia ocen wszystkich książek' FROM ocena_ksiazki 
 
-- Wyświetlić wszystkie oceny dla książki dla których ocena jest większa od średniej oceny dla wszyskich książek 
--(nie pomylić ze średnia wszystkich ocen) 
R:
SELECT  ocena, (SELECT AVG(ocena) FROM ocena_ksiazki)  AS 'Średnia dla wszystkich książek' FROM  ocena_ksiazki 
WHERE ocena >(SELECT AVG(ocena) AS 'Średnia ocen wszystkich książek' FROM ocena_ksiazki) ;


-- Wyświetlić wszystkie oceny dla ksiażek dla których ocena jest większa od średniej oceny dla wszyskich książek
-- (nie pomylić ze średnia wszystkich ocen) i przy ocenie wyświetlić średnią ocenę dla wszystkich książek
R:

 -- i nieco trudniejsze zadanie wyświetlić wszystkie ksiażki dla których średnia ocena jest większa od średniej oceny 
 -- dla wszyskich książek (nie pomylić ze średnia wszystkich ocen) i przy ocenie wyświetlić średnią ocenę dla książki 
 -- i dla wszystkich książek
R: 
SELECT k.* , ocena AS 'konkretna ocena', avg(ocena) AS 'średnia ocen danej ksiażki', (SELECT SUM(ocena)/count(ocena) FROM ocena_ksiazki) AS 'średnia ze wszystkich książek' 
from ksiazka k, ocena_ksiazki ok WHERE ok.ocena>(SELECT avg(ocena) from ocena_ksiazki)


-- Można to zrobić też na widokach albo dodać dodatkową tabelę ze statystykami - w zależności od sytuacji

-- Inny wynik jakbysmy wzieli srednia wszystkich ocen SELECT k.autor_imie, k.autor_nazwisko, k.tytul, ocena FROM ksiazka k JOIN ocena_ksiazki og USING (ksiazka_id) 
-- WHERE ocena>( SELECT AVG(ocena) FROM ocena_ksiazki)
 