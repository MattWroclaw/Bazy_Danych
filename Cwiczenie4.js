db.kontrole.drop()

db.kontrole.insert({
		"nazwa_portu": "Gdansk",
		"numer_stanowiska": 1,
		"wynik_kontroli": "true",
		"data_kontroli": new Date("2012-04-23T18:25:43.511Z"),
		"czas_kontroli" : 10,
		"ocena_kontroli" : 8,
		"straznik": {
			"imie": "Jan",
			"nazwisko": "Kowalski",
			"stopien": "szeregowy"
		},
		"pasazer": {
			"imie": "Jan",
			"nazwisko": "Kowalski"
		}
})

db.kontrole.insert({
		"nazwa_portu": "Gdansk",
		"numer_stanowiska": 2,
		"wynik_kontroli": "false",
		"data_kontroli": new Date("2012-05-23T18:25:43.511Z"),
		"czas_kontroli" : 20,
		"ocena_kontroli" : 4,
		"straznik": {
			"imie": "Jan",
			"nazwisko": "Kowalski",
			"stopien": "kapitan"
		},
		"pasazer": {
			"imie": "Stanislaw",
			"nazwisko": "Wyspianski"
		}
})

db.kontrole.insert({
		"nazwa_portu": "Gdansk",
		"numer_stanowiska": 2,
		"wynik_kontroli": "false",
		"data_kontroli": new Date("2012-06-23T18:25:43.511Z"),
		"czas_kontroli" : 15,
		"straznik": {
			"imie": "Jan",
			"nazwisko": "Kowalski",
			"stopien": "szeregowy"
		},
		"pasazer": {
			"imie": "Stanislaw",
			"nazwisko": "Wyspianski"
		}
})

db.kontrole.insert({
		"nazwa_portu": "Warszawa",
		"numer_stanowiska": 1,
		"wynik_kontroli": "true",
		"data_kontroli": new Date("2015-04-23T18:25:43.511Z"),
		"czas_kontroli" : 60,
		"straznik": {
			"imie": "Jan",
			"nazwisko": "Nowak",
			"stopien": "szeregowy"
		},
		"pasazer": {
			"imie": "Michal",
			"nazwisko": "Szymanski"
		}
})

db.kontrole.insert({
		"nazwa_portu": "Warszawa",
		"numer_stanowiska": 1,
		"wynik_kontroli": "true",
		"data_kontroli": new Date("2015-04-24T18:25:43.511Z"),
		"czas_kontroli" : 50,
		"ocena_kontroli" : 8,
		"straznik": {
			"imie": "Jan",
			"nazwisko": "Nowak",
			"stopien": "szeregowy"
		},
		"pasazer": {
			"imie": "Wladyslaw",
			"nazwisko": "Bartoszewski"
		}
})

db.kontrole.insert({
		"nazwa_portu": "Warszawa",
		"numer_stanowiska": 2,
		"wynik_kontroli": "true",
		"data_kontroli": new Date("2018-04-24T18:25:43.511Z"),
		"czas_kontroli" : 78,
		"ocena_kontroli" : 5,
		"straznik": {
			"imie": "Tomasz",
			"nazwisko": "Nowak",
			"stopien": "szeregowy"
		},
		"pasazer": {
			"imie": "Wladyslaw",
			"nazwisko": "Bartoszewski"
		}
})

db.kontrole.insert({
		"nazwa_portu": "Warszawa",
		"numer_stanowiska": 2,
		"wynik_kontroli": "true",
		"data_kontroli": new Date("2018-04-29T18:25:43.511Z"),
		"czas_kontroli" : 54,
		"ocena_kontroli" : 1,
		"straznik": {
			"imie": "Tomasz",
			"nazwisko": "Nowak",
			"stopien": "szeregowy"
		},
		"pasazer": {
			"imie": "Jan",
			"nazwisko": "Brzechwa"
		}
})