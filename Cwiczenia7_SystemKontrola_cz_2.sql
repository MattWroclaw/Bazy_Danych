-- ﻿Podstawowe zapytania

-- 1) Wyświetl stażnikow  którzy mają na imie Jan
SELECT imie FROM straznik WHERE imie='Jan';


-- 2) Wyswietl strazników z nazwiskiem Kowalski i zarabiajacych powyżej 1500

SELECT * FROM straznik WHERE nazwisko='Kowalski' AND pensja>1500;

-- 3) Wyswietl staznikow którzy maja inny stopień niż 'Szeregowiec'
SELECT * FROM straznik WHERE stopien <>'Szeregowiec';


-- 4) Wyświetl srażników którzy zarabiaja w granicach (1500,2500)

SELECT * FROM straznik WHERE pensja BETWEEN 1500 AND 2500;

-- 5) Wyświetlenie wszystkich strażników z tym, że zamiast kolumna 'imie' 
--  chciałbym żeby była kolumna imie_strażnika a po tym wszystkie oryginalne kolumny.

SELECT imie AS imie_straznika, id,nazwisko,stopien,data_zatrudnienia,pensja,skladka_na_ubezpieczenie
FROM straznik ;

-- 6) Wyświetlić strażników ale bez strażników o nazwisku Nowak i Kowalczyk

SELECT * FROM straznik WHERE nazwisko <> 'Nowak' AND nazwisko<>'Kowalski'; 
SELECT * FROM straznik WHERE nazwisko NOT IN ('Nowak', 'Kowalczyl');

-- 7) Wyświetlić strażników ale bez strażników o id 1,6,5 (z użyciem IN)

SELECT * FROM straznik WHERE id NOT IN (1,6,5);

-- 8) Wyświetlić strazników i pensje które są większe od 1500 ale po odjęciu 
-- "skladka_na_ubezpieczenie"

SELECT *, (pensja-skladka_na_ubezpieczenie) AS po_odjęciu_składki_na_bezpiecznie FROM straznik WHERE pensja>1500;

-- 9) Wyświetlić pasażerów posortowanych po nazwisku i imieniu
-- (kolejnosci rosnaca)

SELECT * FROM pasazer order by nazwisko, imie;

-- 10) Wyświetlić strażników którzy mają nazwisko rozpoczynające się od "Kowal"
SELECT * FROM straznik WHERE nazwisko LIKE 'KOwal%';


-- 11) Wyświetlic strażników którzy zatrudnili się miedzy 2017.01.01 a 2020.01.01

SELECT * FROM straznik WHERE data_zatrudnienia> '2017-01-01'
AND
data_zatrudnienia<'2020-01-01';


-- 12) Wyświetlić strażników o nazwisku Nowak i którzy zostali zatrudnieni od 
-- początku poprzedniego roku

-- znalezienie akuaknej daty SELECT now()
-- po sprawdzeniu dok select year(now()-1)
-- str_to_date() wyciąka datę ze stringa
-- ciąg formatujący '%Y str_to_date(year(now()-1, '%Y')

STR_TO_DATE(YEAR(now())-1,'%Y');
-- albo 
SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL -12 MONTH),'%Y-01-01') ;

SELECT * FROM straznik s WHERE nazwisko = 'Nowak' AND s.data_zatrudnienia > str_to_date(YEAR(now())-1, '%Y');

SELECT * FROM straznik s WHERE nazwisko = 'Nowak' AND s.data_zatrudnienia > (date_format(DATE_ADD(now(), INTERVAL - 12 MONTH),
'%Y-01-01'));

-- 13) Wyświetlić nazwisko+pensje strażników 
-- pomniejszone skladka_na_ubezpieczenie,  kolumna ma się nazywać pensja_do_wyplaty

SELECT nazwisko, (pensja-skladka_na_ubezpieczenie) AS pensja_do_wyplaty FROM straznik;
 
-- 14) Wyświetlić wszystkich strażników aktualnych i archiwalnych ( straznik_archiwum) 
-- w jednej tabeli

SELECT *  FROM straznik
union
SELECT *  FROM straznik_archiwum;


-- 15) Zadania to co poprzednio ale posortować strażników po nazwisku i mieniu w kolejności rosnącej


SELECT * FROM (SELECT * FROM straznik UNION SELECT *FROM straznik_archiwum) AS wynikowa order by nazwisko

-- 16) Wyświetlić strażnika który nie ma ustawionego pola skladka_na_ubezpieczenie 
-- (jest to NULL)

SELECT * FROM straznik WHERE skladka_na_ubezpieczenie IS NOT NULL;

-- Używanie agregatów -  
-- ---------------------------
-- 17) Napisać zapytania które poda sumę  pensji (pola pensja) dla wszystkich strażników
SELECT sum(pensja) AS sumaPensjiStraznikow FROM straznik;

-- 18) Podać średnią, minimalną, maksymalną pensję strażników
SELECT avg(pensja) AS średnia, min(pensja) AS minimalna, max(pensja) AS maksymalna from straznik;

-- 19) Podac liczbę  pasażerów w systemie
SELECT count(*) FROM pasazer;

-- 20) Podac liczbe pasazerow ktorych nazwisko rozpoczynają się od K
SELECT  count(*) 
 FROM pasazer where nazwisko  like 'k%';

-- 21) Podać liczbę strażników ale tych którzy mają uzupełnione 
-- pole skladka_na_ubezpieczenie

SELECT * FROM straznik WHERE skladka_na_ubezpieczenie IS NOT NULL;

-- 22) Wyświetlic zestawienie informujące ile jest strażników z określonymi stopniami
SELECT stopien, count(stopien) FROM straznik group by stopien;

-- Zapytania z JOIN
-- -----------------
-- 23) Wyświetlić wszystkie kontrole przeprowadzone na  lotnisku Gdańsk
SELECT k.*, nst.* FROM kontrola k  JOIN numer_stanowiska nst ON nst.id = k.id_numer_stanowiska WHERE nst.nazwa_portu= 'Gdańsk'; 


-- 24) Wyświetlić wszystkie kontrole przeprowadzone dla lotnisku Gdańsk przez strażnika/ów który ma nazwisko 
-- 'Nowak'
SELECT k.*, st.nazwisko, nrst.nazwa_portu 
FROM kontrola k 
INNER JOIN straznik st ON k.id_straznik = st.id -- WHERE nazwisko = 'Nowak'
INNER JOIN numer_stanowiska nrst ON k.id_numer_stanowiska = nrst.id 
WHERE nrst.nazwa_portu='Gdańsk' AND st.nazwisko = 'Nowak';


-- 25) Wyświetlić strażników i przeprowadzone przez nich kontrole jeśli strażnik 
-- nie ma kontroli to wyświetlamy informację o strażniku a w części kontrolu 
-- wyświetlamy nulle 

SELECT st.*, k.* FROM straznik st LEFT JOIN kontrola k ON (st.id = k.id_straznik);

-- 26) Wyświetlić wszystkie lotniska odwiedzone przez pasażera imie="Jan"  

SELECT nrst.nazwa_portu, p.* FROM pasazer p 
INNER JOIN kontrola k ON (p.id=k.id_pasazer)
INNER JOIN numer_stanowiska nrst ON (k.id_numer_stanowiska = nrst.id)
WHERE p.imie = 'Jan'; 

SELECT DISTINCT nrst.nazwa_portu FROM pasazer p 
INNER JOIN kontrola k ON (p.id=k.id_pasazer)
INNER JOIN numer_stanowiska nrst ON (k.id_numer_stanowiska = nrst.id)
WHERE p.imie = 'Jan'; 
  
-- Tworzenie tabel
-- 27) Dodaj dodatkowa kolumne 'plec' do tablicy 'pasazer' tak zeby nie kasowac danych. 
-- Uzyj polecenie ALTER TABLE

ALTER TABLE pasazer ADD plec char(1);

-- 28) Dodac kolumnę 'Naz_dyrektora_portu' w tabeli 'port_lotniczy'
ALTER TABLE port_lotniczy ADD Naz_dyrektora_portu char(10);

-- 29) Zmien nazwe kolumny 'Naz_dyrektora_portu' w tabeli 'port_lotniczy na 'Dyrektor_portu' uzyj do tego polecanie
-- ALTER TABLE ..

ALTER TABLE port_lotniczy CHANGE Naz_dyrektora_portu  Dyrektor_portu char(10);

-- 30) Stwórz tabelę "Poszukiwane_osoby", tablica powinna zawierać pola imie, nazwisko, date poszukiwanego
CREATE TABLE poszukiwane_osoby (
id_poszukiwanego int primary key auto_increment not null,
imie CHAR(10),
nazwisko CHAR(10),
data_poszukiwanego datetime
);
SHOW tables ;
DROP table poszukiwane_osoby

-- 31) Stwórz tabele 'Osoby_schwytane' która będzie informowała ktory strażnik schwytał którego poszukiwanego. 
-- Stworz niezbędne ograniczenia.

CREATE TABLE osoby_schwytane (
id_schwytanego int auto_increment PRIMARY KEY,
id_poszukiwanego int,
id_straznika INT8,

FOREIGN KEY (id_poszukiwanego) REFERENCES poszukiwane_osoby(id_poszukiwanego) ON DELETE CASCADE,
FOREIGN KEY (id_straznika) REFERENCES straznik(id) ON DELETE CASCADE
);

DROP TABLE osoby_schwytane;

-- 32) Dodac 3 osoby do tablicy poszukiwane_osoby oraz dodac jeden wiersz osoby_schwytane

INSERT INTO poszukiwane_osoby ( imie , nazwisko ,data_poszukiwanego )
VALUES ('Franiu' , 'Mordka', now());

INSERT INTO poszukiwane_osoby ( imie , nazwisko ,data_poszukiwanego )
VALUES ('Zygmunt' , 'Ryjek', now()- interval - 3 MONTH);

INSERT INTO poszukiwane_osoby ( imie , nazwisko ,data_poszukiwanego )
VALUES ('Basia' , 'Pończocha', now()- interval - 5 MONTH);


SELECT * FROM poszukiwane_osoby;

-- 33) Stwórz tabelę 'Lot' opisującą przelot między dwoma lotniskami, posiadajaca informacje o lotnisku startowym
-- i docelowym, numerze lotu i godzinie startu.

CREATE TABLE lot (
lot_id int not null auto_increment primary key,
lotnisko_dep char(200),
lotnisko_arr char(200),
nr_lotu INT,
godzina_startu time,

FOREIGN KEY (lotnisko_dep) REFERENCES port_lotniczy(nazwa_portu) ON DELETE CASCADE,
FOREIGN KEY (lotnisko_arr) REFERENCES port_lotniczy(nazwa_portu) ON DELETE CASCADE
);

 
-- 34) Stworz tabele 'Przelot' pozwalającą przechować informacje o przelotach pasażera (musi być powiazana do tablicy 'Lot')
CREATE TABLE przelot (
przelot INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_pasazera bigint,
lot_id INT,

FOREIGN KEY (id_pasazera) REFERENCES pasazer(id),
FOREIGN KEY (lot_id) REFERENCES lot(lot_id)
);

-- 35) Dodac 3 wiersze w tabeli Lot dla 2 roznych lotnisk

INSERT INTO lot ( lotnisko_dep,lotnisko_arr,nr_lotu,godzina_startu)
VALUES ( 'Wrocław' , ' Gdańsk' , 1, now());

-- 36) Dodac 3 wiersze w tabeli przelot

-- MODYFIKACJA DANYCH
-- 37) Umieścić wiersz z swoimi danymi w tablicy pasażera i dodać 
-- kontrole na lotnisku Gdańsk przez strażnika id=1 w dniu dzisiejszym

-- 38) Zmienić nazwisko strażników z 'Nowak' na 'Nowakowski' przy okazji 
-- zwiększając im pensje o 10%


-- 39) Skasować wiersz  z swoim wpisem w tablicy pasażer.

-- 40) Skasować strażnika który skontrolował największa liczbę pasażerów.


-- PODZAPYTANIA
-- 41) Wyświetlić wszystkie kontrole przeprowadzone dla lotniksa Gdańsk przez strażnika
-- który ma największe zarobki

-- 42) Wyświetlić z użyciem podzapytania wszystkich pasażerów skontrolowanych 
-- przez strażników o nazwisku "Nowak"

-- 43) Wyświetlić strażników a w ostatniej kolumnie kwotę najwyższej pensji 
-- strażnika

-- 44) Wyświetlić strażników a w ostatniej kolumnie informację o ile mniej/więcej zarabia dany strażnik od średniej  

-- Zlozone
-- 45) Wyświetlić pasażera który  nigdy nie był kontrolowany. 


-- 46) Znaleźć pasażera który odwiedził największą ilość lotnisk (użyć LIMIT), 
-- wyświetlić jaką liczbę lotnisk odwiedzili (jeśli pasażer odwiedził dwa razy to samo lotnisko
-- to zliczamy to jako jedno odwiedzenie)

-- 47) Znaleźć 2 strażników którzy skontrolowali największą ilość pasażerów
-- (ponowna kontrola pasażera zliczana jest jako dodatkowa kontrola)


-- 48) Znaleźć lotnisko na którym poleciała najmniejsza ilość pasażer
--  (ale większa od 0)

-- 49) Znaleźć miesiac (w przeciagu całego okresu)  w którym był największy ruch na 
-- wszystkich lotniskach. Użyć	date_format()
	
-- 50) Wyświetlić  ilość pasażerów w kolejnych latach dla każdego lotniska  
-- (lotnisko sortujemy według nazwy rosnąco a póxniej według roku)

-- ﻿Podstawowe zapytania

-- 1) Wyświetl stażnikow  którzy mają na imie Jan
SELECT imie FROM straznik WHERE imie='Jan';


-- 2) Wyswietl strazników z nazwiskiem Kowalski i zarabiajacych powyżej 1500

SELECT * FROM straznik WHERE nazwisko='Kowalski' AND pensja>1500;

-- 3) Wyswietl staznikow którzy maja inny stopień niż 'Szeregowiec'
SELECT * FROM straznik WHERE stopien <>'Szeregowiec';


-- 4) Wyświetl srażników którzy zarabiaja w granicach (1500,2500)

SELECT * FROM straznik WHERE pensja BETWEEN 1500 AND 2500;

-- 5) Wyświetlenie wszystkich strażników z tym, że zamiast kolumna 'imie' 
--  chciałbym żeby była kolumna imie_strażnika a po tym wszystkie oryginalne kolumny.

SELECT imie AS imie_straznika, id,nazwisko,stopien,data_zatrudnienia,pensja,skladka_na_ubezpieczenie
FROM straznik ;

-- 6) Wyświetlić strażników ale bez strażników o nazwisku Nowak i Kowalczyk

SELECT * FROM straznik WHERE nazwisko <> 'Nowak' AND nazwisko<>'Kowalski'; 


-- 7) Wyświetlić strażników ale bez strażników o id 1,6,5 (z użyciem IN)

SELECT * FROM straznik WHERE id NOT IN (1,6,5);

-- 8) Wyświetlić strazników i pensje które są większe od 1500 ale po odjęciu 
-- "skladka_na_ubezpieczenie"

SELECT *, (pensja-skladka_na_ubezpieczenie) FROM straznik WHERE pensja>1500;

-- 9) Wyświetlić pasażerów posortowanych po nazwisku i imieniu
-- (kolejnosci rosnaca)

SELECT * FROM pasazer order by nazwisko, imie;

-- 10) Wyświetlić strażników którzy mają nazwisko rozpoczynające się od "Kowal"
SELECT * FROM straznik WHERE nazwisko LIKE 'KOwal%';


-- 11) Wyświetlic strażników którzy zatrudnili się miedzy 2017.01.01 a 2020.01.01

SELECT * FROM straznik WHERE data_zatrudnienia> 2017.01.01




-- 12) Wyświetlić strażników o nazwisku Nowak i którzy zostali zatrudnieni od 
-- początku poprzedniego roku

STR_TO_DATE(YEAR(now())-1,'%Y')

-- albo 

SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL -12 MONTH),'%Y-01-01') ;

-- 13) Wyświetlić nazwisko+pensje strażników 
-- pomniejszone skladka_na_ubezpieczenie,  kolumna ma się nazywać pensja_do_wyplaty
 
-- 14) Wyświetlić wszystkich strażników aktualnych i archiwalnych ( straznik_archiwum) 
-- w jednej tabeli

-- 15) Zadania to co poprzednio ale posortować strażników po nazwisku i mieniu w kolejności rosnącej

-- 16) Wyświetlić strażnika który nie ma ustawionego pola skladka_na_ubezpieczenie 
-- (jest to NULL)

-- Używanie agregatów -  
-- ---------------------------
-- 17) Napisać zapytania które poda sumę  pensji (pola pensja) dla wszystkich strażników

-- 18) Podać średnią, minimalną, maksymalną pensję strażników

-- 19) Podac liczbę  pasażerów w systemie

-- 20) Podac liczbe pasazerow ktorych nazwisko rozpoczynają się od K

-- 21) Podać liczbę strażników ale tych którzy mają uzupełnione 
-- pole skladka_na_ubezpieczenie


-- 22) Wyświetlic zestawienie informujące ile jest strażników z określonymi stopniami

-- Zapytania z JOIN
-- -----------------
-- 23) Wyświetlić wszystkie kontrole przeprowadzone na  lotnisku Gdańsk


-- 24) Wyświetlić wszystkie kontrole przeprowadzone dla lotnisku Gdańsk przez strażnika/ów który ma nazwisko 
-- 'Nowak'

-- 25) Wyświetlić strażników i przeprowadzone przez nich kontrole jeśli strażnik 
-- nie ma kontroli to wyświetlamy informację o strażniku a w części kontrolu 
-- wyświetlamy nulle 

-- 26) Wyświetlić wszystkie lotniska odwiedzone przez pasażera imie="Jan"  

  
-- Tworzenie tabel
-- 27) Dodaj dodatkowa kolumne 'plec' do tablicy 'pasazer' tak zeby nie kasowac danych. 
-- Uzyj polecenie ALTER TABLE

-- 28) Dodac kolumnę 'Naz_dyrektora_portu' w tabeli 'port_lotniczy'

-- 29) Zmien nazwe kolumny 'Naz_dyrektora_portu' w tabeli 'port_lotniczy na 'Dyrektor_portu' uzyj do tego polecanie
-- ALTER TABLE ..

-- 30) Stwórz tabelę "Poszukiwane_osoby", tablica powinna zawierać pola imie, nazwisko, date poszukiwanego

-- 31) Stwórz tabele 'Osoby_schwytane' która będzie informowała ktory strażnik schwytał którego poszukiwanego. 
-- Stworz niezbędne ograniczenia.

-- 32) Dodac 3 osoby do tablicy poszukiwane_osoby oraz dodac jeden wiersz osoby_schwytane

-- 33) Stwórz tabelę 'Lot' opisującą przelot między dwoma lotniskami, posiadajaca informacje o lotnisku startowym
-- i docelowym, numerze lotu i godzinie startu.
 
-- 34) Stworz tabele 'Przelot' pozwalającą przechować informacje o przelotach pasażera (musi być powiazana do tablicy 'Lot')

-- 35) Dodac 3 wiersze w tabeli Lot dla 2 roznych lotnisk

-- 36) Dodac 3 wiersze w tabeli przelot

-- MODYFIKACJA DANYCH
-- 37) Umieścić wiersz z swoimi danymi w tablicy pasażera i dodać 
-- kontrole na lotnisku Gdańsk przez strażnika id=1 w dniu dzisiejszym

-- 38) Zmienić nazwisko strażników z 'Nowak' na 'Nowakowski' przy okazji 
-- zwiększając im pensje o 10%


-- 39) Skasować wiersz  z swoim wpisem w tablicy pasażer.

-- 40) Skasować strażnika który skontrolował największa liczbę pasażerów.


-- PODZAPYTANIA
-- 41) Wyświetlić wszystkie kontrole przeprowadzone dla lotniksa Gdańsk przez strażnika
-- który ma największe zarobki

-- 42) Wyświetlić z użyciem podzapytania wszystkich pasażerów skontrolowanych 
-- przez strażników o nazwisku "Nowak"

-- 43) Wyświetlić strażników a w ostatniej kolumnie kwotę najwyższej pensji 
-- strażnika

-- 44) Wyświetlić strażników a w ostatniej kolumnie informację o ile mniej/więcej zarabia dany strażnik od średniej  

-- Zlozone
-- 45) Wyświetlić pasażera który  nigdy nie był kontrolowany. 


-- 46) Znaleźć pasażera który odwiedził największą ilość lotnisk (użyć LIMIT), 
-- wyświetlić jaką liczbę lotnisk odwiedzili (jeśli pasażer odwiedził dwa razy to samo lotnisko
-- to zliczamy to jako jedno odwiedzenie)

-- 47) Znaleźć 2 strażników którzy skontrolowali największą ilość pasażerów
-- (ponowna kontrola pasażera zliczana jest jako dodatkowa kontrola)


-- 48) Znaleźć lotnisko na którym poleciała najmniejsza ilość pasażer
--  (ale większa od 0)

-- 49) Znaleźć miesiac (w przeciagu całego okresu)  w którym był największy ruch na 
-- wszystkich lotniskach. Użyć	date_format()
	
-- 50) Wyświetlić  ilość pasażerów w kolejnych latach dla każdego lotniska  
-- (lotnisko sortujemy według nazwy rosnąco a póxniej według roku)

