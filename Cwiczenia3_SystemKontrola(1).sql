SET NAMES 'utf8';
SET CHARACTER SET utf8;

DROP TABLE IF EXISTS przyznane_nagrody;
DROP TABLE IF EXISTS kontrola;
DROP TABLE IF EXISTS straznik;
DROP TABLE IF EXISTS numer_stanowiska;
DROP TABLE IF EXISTS port_lotniczy;
DROP TABLE IF EXISTS pasazer;

CREATE TABLE straznik (
	id		    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 	
	imie		    CHAR(200) NOT NULL,
	nazwisko	    CHAR(200) NOT NULL,
	stopien	    CHAR(50)  NOT NULL CHECK (stopien='Szeregowiec' OR stopien='Starszy szeregowiec' OR stopien='Kapral' OR stopien='Starszy kapral'),
	data_zatrudnienia   DATETIME,
	pensja		    NUMERIC(8,2) NOT NULL CHECK(pensja>=0)
);

CREATE TABLE przyznane_nagrody (
	straznik_id	    INT8  NOT NULL,
	nazwa	            CHAR(200) NOT NULL,
	data_przyznania	    DATETIME ,
    FOREIGN KEY (straznik_id) REFERENCES straznik(id),
	PRIMARY KEY (straznik_id, nazwa, data_przyznania)
);


CREATE TABLE port_lotniczy (
	nazwa_portu	CHAR(200) PRIMARY KEY
);

CREATE TABLE numer_stanowiska (
	id		BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	nazwa_portu	CHAR(200) NOT NULL,
	numer  		INT NOT NULL,
    FOREIGN KEY (nazwa_portu) REFERENCES port_lotniczy(nazwa_portu)
);


CREATE TABLE pasazer (
	id		BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	imie		CHAR(100) NOT NULL,
	nazwisko	CHAR(100) NOT NULL
);


DROP TABLE IF EXISTS kontrola;
CREATE TABLE kontrola (
	id_straznik		INT8 NOT NULL,
	id_pasazer		INT8 NOT NULL,
	id_numer_stanowiska     INT8 NOT NULL ,
	wynik_kontroli		BOOLEAN NOT NULL,
	czas_kontroli 		DATETIME  NOT NULL DEFAULT   CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_straznik) REFERENCES straznik(id),
    FOREIGN KEY (id_pasazer) REFERENCES  pasazer(id),
    FOREIGN KEY (id_numer_stanowiska) REFERENCES numer_stanowiska(id)
);

-- przykadowe dane
INSERT INTO straznik (imie, nazwisko, stopien, data_zatrudnienia, pensja) 
VALUES 
	('Jan', 'Kowalski', 'Szeregowiec',        now(), 1500),
	('Jan', 'Nowak'   , 'Starszy szeregowiec', now(), 2000);

INSERT INTO przyznane_nagrody (straznik_id,nazwa, data_przyznania) VALUES 
	(1, 'Przepracowane 10 lat pracy', now()) , (1, 'Nagroda generała', now());

INSERT INTO port_lotniczy (nazwa_portu) VALUES ('Gdańsk'), ('Warszawa'), ('Szczecin');

INSERT INTO numer_stanowiska (nazwa_portu, numer) VALUES
	('Gdańsk', 1), ('Gdańsk',2), ('Gdańsk',3),
	('Warszawa',1), ('Warszawa',2), ('Warszawa',3), ('Warszawa',4),
	('Szczecin',1), ('Szczecin',2), ('Szczecin',3);

INSERT INTO pasazer (imie, nazwisko) VALUES ('Jan', 'Brzechwa'), ('Stanisław', 'Wyspański'), ('Henryk','Sienkiewicz');

INSERT INTO kontrola (id_straznik, id_pasazer, id_numer_stanowiska, wynik_kontroli, czas_kontroli) VALUES 
 (1, 1, 1, true, now()),
 (1, 2, 1, false, now()),
 (2, 2, 4, true, now()),
 (2, 2, 5, true, now());