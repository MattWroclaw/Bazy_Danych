-- ===================== 4.1 Indeksy  ============================

-- wyszukanie pasazera
SELECT * FROM pasazer WHERE  imie='Olgierd' AND nazwisko='Szymański'; -- 1.8-7s
CREATE INDEX pasazer_imie_nazwisko_indx ON pasazer(imie,nazwisko);  
SELECT * FROM  pasazer WHERE  imie='Olgierd' AND nazwisko='Siewierski'; -- 11ms
SELECT * FROM  pasazer WHERE  imie='Olgierd' AND nazwisko='Szymański'; -- 11ms

-- wyswietlenie skontrolowanych pasazerow skontrolowanych przez jednego straznika
SELECT * FROM kontrola JOIN pasazer p ON (id_pasazer=p.id)  -- 9-31s
JOIN straznik s  ON (s.id=id_straznik) 
WHERE s.imie='Zenon' AND s.nazwisko='Kleba'  AND
czas_kontroli>='1972-10-29 00:00' AND czas_kontroli<'1972-10-29 7:00' LIMIT 100;

/*
Indeks
*/
CREATE INDEX kontrola_id_straznik_indx ON kontrola (id_straznik);  -- 0.3s

-- wyswietlenie definicji tablicy
SHOW CREATE TABLE kontrola;


-- wyświetlenie portow lotniczych
SELECT * FROM port_lotniczy;

-- wyswietlenie liste wszystkich kontroli dla wybranego numeru stanowiska  (około 18-36s) 
SELECT * FROM kontrola k 
JOIN pasazer p ON              (k.id_pasazer=p.id) 
JOIN numer_stanowiska ns ON (k.id_numer_stanowiska=ns.id)
JOIN straznik s ON             (k.id_straznik=s.id)
WHERE
 ns.nazwa_portu = 'Gdańsk' AND
 ns.numer=1 AND
 k.czas_kontroli>='1972-10-29 00:00' AND k.czas_kontroli<'2018-10-29 7:00';

CREATE INDEX kontrola_czas_kontrola_id_numer_stanowiskaindx ON  kontrola (czas_kontroli,id_numer_stanowiska);  -- 2 sekundy
-- czyli przyspieszyliszmy jakieś 10x


--- ========== Ciekawy przypadek ========= ---
-- Chcemy skasować  pierwszych trzech strażników z tabeli 'straznik' - banalne zadanie

-- Dodanie kaskadowego kasowania 
ALTER TABLE kontrola DROP FOREIGN KEY kontrola_ibfk_1;
ALTER TABLE  kontrola
  ADD CONSTRAINT kontrola_id_straznik_fkey FOREIGN KEY (id_straznik)
      REFERENCES  straznik (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;
      
ALTER TABLE  przyznane_nagrody DROP FOREIGN KEY przyznane_nagrody_ibfk_1;   --- wyjaśnić źródło komendy
ALTER TABLE  przyznane_nagrody
  ADD CONSTRAINT przyznane_nagrody_straznik_id_fkey FOREIGN KEY (straznik_id)
      REFERENCES  straznik (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

-- szukamy 3 pierwszych strażników
SELECT * FROM  straznik ORDER BY id LIMIT 3

-- to kasujemy 
EXPLAIN DELETE FROM  straznik WHERE id IN (1,2,3);

-- coś strasznie wolno....
-- ..a jaki jest plan zapytania
"Delete on straznik  (cost=0.28..16.89 rows=3 width=6)"
"  ->  Index Scan using straznik_pkey on straznik  (cost=0.28..16.89 rows=3 width=6)"
"        Index Cond: (id = ANY ('{1,2,3}'::bigint[]))"

-- ============= Ćwiczenia co jest nie tak.. ==============
-- ..lepiej być nie może... to co jest źle? Jakieś propozycje? 


-- Prosze stworzyc indeks na tablicy kontrola na polu id_straznik
R:
  
  
-- =========================== STATYSTYKI ==============================
SELECT * FROM INFORMATION_SCHEMA.STATISTICS
SHOW INDEX FROM kontrola
  
  
-- ===================== 4.2 Trigery ============================
-- Ćwiczenia
-- Dodać trigger który ustawia date w "data_zatrudniania" na now() w momencie dodawania wiersza w  straznik

/* definicja procedury */
DROP TRIGGER set_data_zatrudnienia;

delimiter //
CREATE TRIGGER set_data_zatrudnienia BEFORE INSERT ON straznik
     FOR EACH ROW
     BEGIN
         SET NEW.data_zatrudnienia = now();
         
     END;//
delimiter ;



INSERT INTO  straznik (imie, nazwisko, stopien, pensja) 
VALUES 
	('Jan3', 'Kowalski3', 'Szeregowiec', 1500),
	('Jan3', 'Nowak3'   , 'Starszy szeregowiec', 2000);

SELECT * FROM  straznik ORDER BY id DESC LIMIT 2;

-- ===================== 4.3 Tranzackcje ============================
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- ====== Dzialanie ROLLBACK/COMMIT ======

DELETE FROM straznik WHERE nazwisko LIKE "Tran%"; 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SHOW VARIABLES like 'tx_isolation';
START TRANSACTION;
INSERT INTO  straznik (imie, nazwisko, stopien, pensja)  VALUES 
	('Jan', 'Tranzakcja100', 'Szeregowiec', 1500);
SELECT * FROM straznik WHERE nazwisko LIKE "Tran%"; 
ROLLBACK; --  COMMIT;
SELECT * FROM straznik; 

-- Pokaz dzialania tranzaji
-- W drugiej sesji
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT * FROM straznik WHERE nazwisko LIKE "Tran%";  
COMMIT;
SELECT * FROM straznik WHERE nazwisko LIKE "Tran%"; 

-- ====== Dzialanie ROLLBACK/COMMIT z UPDATE ======

-- ==SESJA 1==
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT * FROM straznik WHERE nazwisko="Tranzakcja100";
UPDATE straznik SET imie="JAN" WHERE nazwisko="Tranzakcja100";
SELECT * FROM straznik WHERE nazwisko="Tranzakcja100";
COMMIT;

-- ==SESJA 2==
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT * FROM straznik WHERE nazwisko="Tranzakcja100";
UPDATE straznik SET imie="TOM" WHERE nazwisko="Tranzakcja100";
-- RUNNING -
SELECT * FROM straznik WHERE nazwisko="Tranzakcja100";
COMMIT;

-- ===================== 4.4 Widoki =====================
-- Stworzenie widoku który wyświetla dane - pasażer + data kontroli + nazwa lotniska
-- DROP VIEW  PasazerPodroze
CREATE VIEW  PasazerPodroze AS
SELECT imie, nazwisko, czas_kontroli, nazwa_portu, id_straznik FROM
 kontrola k JOIN  pasazer p ON (k.id_pasazer=p.id) 
JOIN  numer_stanowiska ns ON (k.id_numer_stanowiska=ns.id);

-- użycie 
SELECT * FROM  PasazerPodroze LIMIT 100;

-- mozna ten widok połączyć z inną tabelą
SELECT * FROM  PasazerPodroze pp JOIN  straznik  s ON (pp.id_straznik=s.id) LIMIT 100;

-- co odpowiada
SELECT * FROM 
(SELECT p.imie, p.nazwisko, k.czas_kontroli, ns.nazwa_portu,k.id_straznik FROM
  kontrola k JOIN  pasazer p ON (k.id_pasazer=p.id) 
 JOIN  numer_stanowiska ns ON (k.id_numer_stanowiska=ns.id)
) pp 
JOIN  straznik  s ON (pp.id_straznik=s.id)
LIMIT 100;
 
-- ĆWICZENIA
-- Prosze o stworzenie widoku StraznikNagrody który wyświetla następujące pola
--   Strażnik imię+nazwisko, Nazwa nagrody, Data przyznania nagrody
R:

