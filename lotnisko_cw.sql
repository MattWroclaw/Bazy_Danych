
-- CREATE DATABASE `system_kontroli` /*!40100 DEFAULT CHARACTER SET utf8 */;

DROP TABLE IF EXISTS stanowisko CASCADE;
DROP TABLE IF EXISTS kontrola CASCADE;
DROP TABLE IF EXISTS lotnisko CASCADE;
DROP TABLE IF EXISTS przyznane_nagrody CASCADE;
DROP TABLE IF EXISTS straznik CASCADE;

DROP TABLE IF EXISTS pasazer CASCADE;

CREATE TABLE pasazer (
pasazer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
imie_pas CHAR(20) NOT NULL, 
nazwisko_pas CHAR(20) NOT NULL,
data_urodzenia DATE
);

DROP INDEX pasazer_id_indx ON pasazer;
CREATE INDEX imie_pas_indx ON pasazer(imie_pas);

CREATE TABLE straznik(
straznik_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
imie_pas CHAR(20) NOT NULL,
nazwisko CHAR(20) NOT NULL,
stopien CHAR(20) NOT NULL,
data_zatrudnienia DATE NOT NULL,
pensja NUMERIC(8,2) NOT NULL
);

DROP TRIGGER set_data_zatrudnienia;

delimiter //
CREATE TRIGGER set_data_zatrudnienia BEFORE INSERT ON straznik
     FOR EACH ROW
     BEGIN
         SET NEW.data_zatrudnienia = now();
         SET NEW.stopien = 'zajac';
     END;//
     delimiter ;
     
insert into straznik (imie_pas,nazwisko,stopien,data_zatrudnienia,pensja)
values ('Kuku', 'Haha', 'st. str', '2012-04-01', '2500');




CREATE TABLE przyznane_nagrody(
straznik_id INT NOT NULL,
nazwa CHAR(100) NOT NULL,
data_przyznania DATE,
foreign key (straznik_id) REFERENCES straznik(straznik_id),
PRIMARY KEY (straznik_id, nazwa, data_przyznania)
);


CREATE TABLE lotnisko(
nazwa_lotniska CHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE stanowisko(
numer_stanowiska INT  NOT NULL ,
nazwa_lotniska CHAR(10) NOT NULL,
foreign key (nazwa_lotniska) references lotnisko (nazwa_lotniska),
primary key (numer_stanowiska, nazwa_lotniska)
);

CREATE TABLE kontrola(
kontrolaID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
wynik_kontorli BOOLEAN NOT NULL,
data_kontroli DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
numer_stanowiska INT not NULL ,
pasazer_id INT NOT NULL,
straznik_id INT NOT NULL,
foreign key (numer_stanowiska) references stanowisko (numer_stanowiska),
foreign key (pasazer_id) references pasazer (pasazer_id),
foreign key (straznik_id) references straznik (straznik_id)
);

