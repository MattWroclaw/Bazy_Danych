SET NAMES  'utf8';
SET CHARACTER SET utf8;
DROP TABLE IF EXISTS kontrola;
DROP TABLE IF EXISTS numer_stanowiska;
DROP TABLE IF EXISTS port_lotniczy;
DROP TABLE IF EXISTS przyznane_nagrody;
DROP TABLE IF EXISTS straznik;
 
CREATE TABLE  straznik (
	id		    	BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	imie		    CHAR(200) NOT NULL,
	nazwisko	    CHAR(200) NOT NULL,
	stopien		    CHAR(50)  NOT NULL CHECK (stopien='Szeregowiec' OR stopien='Starszy szeregowiec' OR stopien='Kapral' OR stopien='Starszy kapral'),
	data_zatrudnienia   DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	pensja		    NUMERIC(8,2) NOT NULL CHECK(pensja>=0),
	skladka_na_ubezpieczenie NUMERIC(8,2)
);

DROP TABLE IF EXISTS straznik_archiwum;
CREATE TABLE  straznik_archiwum (
	id		    	BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,      
	imie		    CHAR(200) NOT NULL,
	nazwisko	    CHAR(200) NOT NULL,
	stopien		    CHAR(50)  NOT NULL CHECK (stopien='Szeregowiec' OR stopien='Starszy szeregowiec' OR stopien='Kapral' OR stopien='Starszy kapral'),
	data_zatrudnienia   DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	pensja		    NUMERIC(8,2) NOT NULL CHECK(pensja>=0),
	skladka_na_ubezpieczenie NUMERIC(8,2)
);

CREATE TABLE  przyznane_nagrody (
	straznik_id	    INT8  NOT NULL REFERENCES  straznik(id),
	nazwa	            CHAR(200) NOT NULL,
	data_przyznania	    DATETIME  NOT NULL,
	PRIMARY KEY (straznik_id, nazwa, data_przyznania)
);

CREATE TABLE  port_lotniczy (
	nazwa_portu	CHAR(200) PRIMARY KEY
);

CREATE TABLE  numer_stanowiska (
	id		BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	nazwa_portu	CHAR(200) NOT NULL,
	numer  		INT NOT NULL ,
    FOREIGN KEY (nazwa_portu) REFERENCES port_lotniczy(nazwa_portu)
);

DROP TABLE IF EXISTS pasazer;
CREATE TABLE  pasazer (
	id			BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	imie		CHAR(100) NOT NULL,
	nazwisko	CHAR(100) NOT NULL
);


CREATE TABLE  kontrola (
	id_straznik		INT8 NOT NULL,
	id_pasazer		INT8 NOT NULL,
	id_numer_stanowiska     INT8 NOT NULL,
	wynik_kontroli		BOOLEAN NOT NULL,
	czas_kontroli 		DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY  (id_straznik,id_pasazer,id_numer_stanowiska,czas_kontroli),
    
    FOREIGN KEY (id_straznik) REFERENCES straznik(id) ON DELETE CASCADE,
	FOREIGN KEY (id_pasazer) REFERENCES pasazer(id) ON DELETE CASCADE,
	FOREIGN KEY (id_numer_stanowiska) REFERENCES numer_stanowiska(id) ON DELETE CASCADE
);

-- przykładowe dane
INSERT INTO  straznik (imie, nazwisko, stopien, data_zatrudnienia, pensja,skladka_na_ubezpieczenie) 
VALUES 
	('Jan', 'Kowalski', 'Szeregowiec',                DATE_ADD(now(), INTERVAL -10 MONTH), 1500, 300),
	('Marek', 'Nowak'   , 'Starszy szeregowiec',      DATE_ADD(now(), INTERVAL -12 MONTH), 2300, 3320),
	('Franciszek', 'Kowalczyk', 'Szeregowiec',        DATE_ADD(now(), INTERVAL -50 MONTH), 1300,290),
	('Zdzisław', 'Nowak'   , 'Starszy szeregowiec',   DATE_ADD(now(), INTERVAL -11 MONTH), 2200,500),
	('Teofil', 'Kowalski', 'Szeregowiec',             DATE_ADD(now(), INTERVAL -1 MONTH), 2500,200),
	('Jan', 'Nowak'   , 'Starszy szeregowiec',        DATE_ADD(now(), INTERVAL -2 MONTH), 3000,200),
	('Jan', 'Nowakowski'   , 'Starszy szeregowiec',   DATE_ADD(now(), INTERVAL -2 MONTH), 3000,200);

INSERT INTO  straznik_archiwum (imie, nazwisko, stopien, data_zatrudnienia, pensja,skladka_na_ubezpieczenie) 
VALUES 
	('Stefan', 'Jeziorański', 'Szeregowiec',        DATE_ADD(now(), INTERVAL -32 MONTH), 1500, 300);

INSERT INTO  przyznane_nagrody (straznik_id,nazwa, data_przyznania) VALUES 
	(1, 'Przepracowane 10 lat pracy',   DATE_ADD(now(), INTERVAL -20 MONTH)) , 
	(2, 'Nagroda generała',             DATE_ADD(now(), INTERVAL -11 MONTH)),
	(3, 'Przepracowane 15 lat pracy',   DATE_ADD(now(), INTERVAL -23 MONTH)) , 
	(4, 'Nagroda pułkownika',           DATE_ADD(now(), INTERVAL -43 MONTH)),
	(5, 'Przepracowane 20 lat pracy',   DATE_ADD(now(), INTERVAL -23 MONTH)) , 
	(6, 'Nagroda generała',             DATE_ADD(now(), INTERVAL -5 MONTH));

INSERT INTO  port_lotniczy (nazwa_portu) VALUES ('Gdańsk'), ('Warszawa'), ('Szczecin');

INSERT INTO  numer_stanowiska (nazwa_portu, numer) VALUES
	('Gdańsk', 1), ('Gdańsk',2), ('Gdańsk',3),
	('Warszawa',1), ('Warszawa',2), ('Warszawa',3), ('Warszawa',4),
	('Szczecin',1), ('Szczecin',2), ('Szczecin',3)	
	;

INSERT INTO  pasazer (imie, nazwisko) 
VALUES 
	('Jan', 'Brzechwa'), 
	('Stanisław', 'Wyspański'), 
	('Henryk','Sienkiewicz'),
	('Władysław', 'Bartoszewski'),
	('Stefan', 'Żeromski'),
	('Maria', 'Konopnicka'),
	('Maria', 'Kownacka');

INSERT INTO  kontrola (id_straznik, id_pasazer, id_numer_stanowiska, wynik_kontroli, czas_kontroli) VALUES 
 (1, 1, 1, true, DATE_ADD(now(), INTERVAL -5 MONTH)),
 (1, 2, 1, false, now()),
 (2, 2, 4, true, DATE_ADD(now(), INTERVAL -5 MONTH)),
 (2, 2, 5, true, DATE_ADD(now(), INTERVAL -15 MONTH)),
 (3, 1, 1, true, DATE_ADD(now(), INTERVAL -2 MONTH)),
 (3, 2, 1, false, DATE_ADD(now(), INTERVAL -25 MONTH)),
 (4, 2, 4, true, now()),
 (5, 2, 5, true, DATE_ADD(now(), INTERVAL -5 MONTH)),
 (6, 1, 1, true, DATE_ADD(now(), INTERVAL -25 MONTH)),
 (3, 2, 1, false, DATE_ADD(now(), INTERVAL -45 MONTH)),
 (4, 2, 4, true, DATE_ADD(now(), INTERVAL -1 MONTH)),
 (5, 2, 5, true, DATE_ADD(now(), INTERVAL -15 MONTH));