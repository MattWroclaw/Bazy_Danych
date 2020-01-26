db.lubimyczytac.insert({
 "tytul" : "Poszukiwanie jutra", 
 "imie"  : "Jan",
 "nazwisko"     : "Kowalski",
 "data_wydania" : new Date("2012-04-23T18:25:43.511Z"),
 "kategoria"    : "biografia",
 "tagi": ["biografia","Polska","wesole"],
 "komentarze" : [
	{ "imie" : "Jan", "nazwisko" : "Nowak", "komentarz": "To jest dobra ksiazka", "ocena" : 4, "data_komentarza" : new Date("2012-04-23T18:25:43.511Z")} 
 ],
 "wydawca" : 
         { 
			"nazwa" : "Arkady",
			"data_rozpoczecia":  new Date("2012-04-23T18:25:43.511Z"),
			"centrala" : "Warszawa"
	 }
});

db.lubimyczytac.insert({
 "tytul" : "Ostani Mohikanin", 
 "imie"  : "James",
 "nazwisko"     : "Fenimore Cooper",
 "data_wydania" : new Date("1820-04-23T18:25:43.511Z"),
 "kategoria"    : "przygodowa",
 "tagi": ["przygoda","USA","indianie"],
 "komentarze" : [
	{ "imie" : "Jan", "nazwisko" : "Kowalski", "komentarz": "Jeśli jesteś zainteresowany indianami to jest to!", "ocena" : 4, "data_komentarza" : new Date("2014-04-23T18:25:43.511Z")} 
 ],
 "wydawca" : 
         { 
			"nazwa" : "Arkady",
			"data_rozpoczecia":  new Date("1952-04-23T18:25:43.511Z"),
			"centrala" : "Warszawa"
	 }
});

db.lubimyczytac.insert({
	"tytul" : "Potop", 
	"imie"  : "Henryk",
	"nazwisko"     : "Sienkiewicz",
	"data_wydania" : new Date("1890-04-23T18:25:43.511Z"),
	"kategoria"    : "historyczna",
	"tagi": ["historyczna","Polska","Szwedzi"],
	"komentarze" : [
	   { "imie" : "Jan", "nazwisko" : "Nowakowski", "komentarz": "Klasyka powieści historycznej", "ocena" : 3, "data_komentarza" : new Date("2002-04-23T18:25:43.511Z")} 
	],
	"wydawca" : 
			{ 
			   "nazwa" : "Arkady",
			   "data_rozpoczecia":  new Date("2012-04-23T18:25:43.511Z"),
			   "centrala" : "Warszawa"
		   }
   });
   
 db.lubimyczytac.insert({
	"tytul" : "Pan Wołodejowski", 
	"imie"  : "Henryk",
	"nazwisko"     : "Sienkiewicz",
	"data_wydania" : new Date("1891-04-23T18:25:43.511Z"),
	"kategoria"    : "historyczna",
	"tagi": ["historyczna","Polska","Turkowie"],
	"komentarze" : [
	   { "imie" : "Jan", "nazwisko" : "Nowakowski", "komentarz": "Zdecydowanie polecane dla miłośników Sienkiewicza", "ocena" : 5, "data_komentarza" : new Date("2013-04-23T18:25:43.511Z")} 
	],
	"wydawca" : 
			{ 
			   "nazwa" : "Klasyka literatury",
			   "data_rozpoczecia":  new Date("2011-04-23T18:25:43.511Z"),
			   "centrala" : "Warszawa"
		   }
   });
   
# Sprawdzamy czy dodało wiersze
db.lubimyczytac.find()
   
# ===== Przykładowe zapytania 

# Znalezienie wszystkich ksiązek które należą do kategorii "historyczna"
db.lubimyczytac.find( {"kategoria" : "historyczna"} )

# Znalezienie wszystkich ksiazek z oceną większą niż 3
db.lubimyczytac.find( { "komentarze.ocena" : {$gt:3}} )

# Znalezienie książek które mają tag "Polska"
db.lubimyczytac.find( { tagi: ["Polska"] } )   => To nie dziala bo musialby miec dokladnie jeden tag

db.lubimyczytac.find( { tagi: { $all: ["Polska"] } } )


