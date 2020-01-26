
INSERT INTO pasazer (imie_pas,nazwisko_pas,data_urodzenia) 
VALUES ('Sam', 'Pies' , '1978-03-12');
INSERT INTO pasazer (imie_pas,nazwisko_pas,data_urodzenia) 
VALUES ('Dżordż', 'Kiełbasa' , '1988-03-12');

INSERT INTO pasazer (imie_pas,nazwisko_pas, data_urodzenia) VALUE ('Gosia', 'Samosia', '1987-07-12');
INSERT INTO pasazer (imie_pas,nazwisko_pas, data_urodzenia) VALUE ('Tosia', 'FLosia', '1982-07-12');
INSERT INTO pasazer (imie_pas,nazwisko_pas, data_urodzenia) VALUE ('Tomek', 'Domek', '1983-07-12');
INSERT INTO pasazer (imie_pas,nazwisko_pas, data_urodzenia) VALUE ('Jarek', 'Zegarek', '1984-07-12');
SELECT * FROM pasazer;


insert into straznik (imie_pas,nazwisko,stopien,data_zatrudnienia,pensja)
values ('Leon', 'Leń', 'st. str', '2012-04-01', '2500');
insert into straznik (imie_pas,nazwisko,stopien,data_zatrudnienia,pensja)
values ('Stefan', 'Pac', 'st. str', '2011-04-01', '2599');


INSERT INTO lotnisko (nazwa_lotniska) value ('wro');
INSERT INTO lotnisko (nazwa_lotniska) value ('gda');
INSERT INTO lotnisko (nazwa_lotniska) value ('waw');
INSERT INTO lotnisko (nazwa_lotniska) value ('tlw');
select * FROM lotnisko;


INSERT INTO przyznane_nagrody (straznik_id, nazwa, data_przyznania) VALUE (1, 'Uznaniowa', now());
SELECT * FROM przyznane_nagrody;

INSERT INTO stanowisko ( numer_stanowiska, nazwa_lotniska) VALUE (1, 'wro');
INSERT INTO stanowisko ( numer_stanowiska, nazwa_lotniska) VALUE (2, 'gda');
INSERT INTO stanowisko ( numer_stanowiska, nazwa_lotniska) VALUE (2, 'waw');
SELECT st.*, lt.* FROM stanowisko st, lotnisko lt;
SELECT * FROM stanowisko WHERE nazwa_lotniska='wro';


INSERT INTO kontrola (wynik_kontorli, data_kontroli, numer_stanowiska, pasazer_id, straznik_id)
VALUE (true, now(), 1, 1, 1);
INSERT INTO kontrola (wynik_kontorli, data_kontroli, numer_stanowiska, pasazer_id, straznik_id)
VALUE (false, now(), 2, 2, 2);
INSERT INTO kontrola (wynik_kontorli, data_kontroli, numer_stanowiska, pasazer_id, straznik_id)
VALUE (true, now(), 1, 3, 1);
SELECT * FROM kontrola;
SELECT * FROM kontrola k, pasazer p, lotnisko l, stanowisko s WHERE pasazer_id=1;

-- widok
CREATE VIEW  PasazerPodroze AS
SELECT imie_pas, nazwisko_pas, data_kontroli, nazwa_lotniska, straznik_id FROM
 kontrola k JOIN  pasazer p ON (k.pasazer_id=p.pasazer_id) 
JOIN  stanowisko ns ON (k.numer_stanowiska=ns.numer_stanowiska);

SELECT * FROM PasazerPodroze