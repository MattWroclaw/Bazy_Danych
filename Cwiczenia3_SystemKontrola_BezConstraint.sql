
-- ---------- System kontrola (bez ograniczen)=======

CREATE TABLE straznik (	
	imie		    CHAR(200),
	nazwisko	    CHAR(200),
	stopien		    CHAR(50),
	data_zatrudnienia   DATETIME ,
	pensja		    NUMERIC(8,2)
);

CREATE TABLE przyznane_nagrody (
	nazwa	            CHAR(200),
	data_przyznania	    DATETIME 
);


CREATE TABLE port_lotniczy (
	nazwa_portu	CHAR(200)
);

CREATE TABLE numer_stanowiska (
	nazwa_portu	CHAR(200),
	numer  		INT
);


CREATE TABLE pasazer (
	imie		CHAR(100),
	nazwisko	CHAR(100)
);

CREATE TABLE kontrola (
	wynik_kontroli		BOOLEAN,
	czas_kontroli 		DATETIME 
);
