SET CHARACTER SET utf8;

DROP TABLE IF EXISTS film2kategoria ;
DROP TABLE IF EXISTS kategoria ;
DROP TABLE IF EXISTS film ;
DROP TABLE IF EXISTS konto_finansowe ;
DROP TABLE IF EXISTS operacje_finansowe ;
DROP TABLE IF EXISTS znajomy ;
DROP TABLE IF EXISTS uzytkownik ;
DROP TABLE IF EXISTS typ_abonamentu ;

CREATE TABLE typ_abonamentu (
rodzaj				CHAR(20) NOT NULL CHECK( rodzaj ='standard' or rodzaj = 'premium')
);

CREATE TABLE uzytkownik (
id_uzytkownika		INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
email 				CHAR(20) NOT NULL,
haslo				CHAR(20) NOT NULL,
rodzaj_abonamentu	CHAR(20) NOT NULL, CHECK( rodzaj ='standard' or rodzaj = 'premium'),
id_znajomego		INT,

FOREIGN KEY (id_znajomego) REFERENCES uzytkownik (id_uzytkownika)
);

DROP TABLE uzytkownik;


-- CREATE TABLE znajomy (
-- id_uzytkownik_zaprasza CHAR(20) NOT NULL,
-- id_uzytkownik_zaproszony CHAR(20) NOT NULL,
-- data_dodania DATE,
-- FOREIGN KEY (id_uzytkownika_zaprasza) REFERENCES uzytkownik (id_uzytkownika),
-- FOREIGN KEY (id_uzytkownik_zaproszony) REFERENCES uzytkownik (id_uzytkownika)
-- );

CREATE TABLE operacje_finansowe (
data_operacji	DATE NOT NULL,
kwota			INT NOT NULL,
kto_uzytkownik_id	INT NOT NULL,
FOREIGN KEY (kto_uzytkownik_id) REFERENCES uzytkownik (id_uzytkownika)
);

DROP TABLE operacje_finansowe;

CREATE TABLE konto_finansowe (
stan_konta INT NOT NULL,
czyje_uzytkownik_id	CHAR(20) NOT NULL,
FOREIGN KEY (czyje_uzytkownik_id) REFERENCES uzytkownik (id_uzytkownika)
);

CREATE TABLE film (
id_film	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nazwa	CHAR(20) NOT NULL,
data_dodania	DATE,
link	CHAR(200)
);

CREATE TABLE kategoria_filmu (
rodzaj	CHAR(20) NOT NULL PRIMARY KEY CHECK (rodzaj = 'komedia' OR rodzaj = 'dramat' OR rodzaj = 'obyczajowy' OR rodzaj = 'western')
);

CREATE TABLE film2kategoria(
film_id	INT NOT NULL,
rodzaj_kategorii CHAR(20),
FOREIGN KEY (rodzaj_kategorii) REFERENCES kategoria_filmu (rodzaj),
FOREIGN KEY (film_id) REFERENCES film (id_film)
);

CREATE TABLE tworcy (
imie 	CHAR(20),
nazwisko	CHAR(20),
id_tworcy INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE film2tworcy (
film_id INT NOT NULL,
tworcy_id INT NOT NULL,
rola 	CHAR(20),
FOREIGN KEY (film_id) REFERENCES film(id_film),
FOREIGN KEY (tworcy_id) REFERENCES tworcy (id_tworcy)
);

 -- DANE
 
 INSERT INTO typ_abonamentu (rodzaj) VALUES ('standard');
 INSERT INTO typ_abonamentu (rodzaj) VALUES ('premium');
 DELETE FROM typ_abonamentu WHERE rodzaj = 'premiun';
 
 INSERT INTO uzytkownik (email, haslo, rodzaj_abonamentu) VALUES ('qwe@qw.pl', '123', 'standard');
 INSERT INTO uzytkownik (email, haslo, rodzaj_abonamentu) VALUES ('asd@qw.pl', '432', 'premium');
 INSERT INTO uzytkownik (email, haslo, rodzaj_abonamentu, id_znajomego) VALUES ('zxc@qw.pl', '654', 'standard', 1);
 INSERT INTO uzytkownik (email, haslo, rodzaj_abonamentu, id_znajomego) VALUES ('rew@qw.pl', '987', 'standard', 1);
 INSERT INTO uzytkownik (email, haslo, rodzaj_abonamentu, id_znajomego) VALUES ('sdf@qw.pl', '756', 'premium',2);
 INSERT INTO uzytkownik (email, haslo, rodzaj_abonamentu, id_znajomego) VALUES ('zcx@qw.pl', '354', 'standard',3);
 INSERT INTO uzytkownik (email, haslo, rodzaj_abonamentu, id_znajomego) VALUES ('xcv@qw.pl', '876', 'standard',4);
 
 INSERT INTO operacje_finansowe( data_operacji, kwota, kto_uzytkownik_id) VALUES ('2019-02-01', 25, 1);
  INSERT INTO operacje_finansowe( data_operacji, kwota, kto_uzytkownik_id) VALUES ('2019-03-01', 45, 1);
 INSERT INTO operacje_finansowe( data_operacji, kwota, kto_uzytkownik_id) VALUES ('2019-04-01', 45, 1);
 INSERT INTO operacje_finansowe( data_operacji, kwota, kto_uzytkownik_id) VALUES ('2019-04-01', 25, 2);
 INSERT INTO operacje_finansowe( data_operacji, kwota, kto_uzytkownik_id) VALUES ('2019-02-03', 25, 3);
 INSERT INTO operacje_finansowe( data_operacji, kwota, kto_uzytkownik_id) VALUES ('2019-02-04', 25, 4);
 INSERT INTO operacje_finansowe( data_operacji, kwota, kto_uzytkownik_id) VALUES ('2019-02-05', 25, 2);
 
 


 