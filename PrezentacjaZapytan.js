# Zalozenie bazu i kolekcji

use Lotnisko
db.createCollection("Samoloty_czolgi")

db.Samoloty_czolgi.insert({ numer_rejestracyjny:"DABV",  typ:"Airbus"})
# Wyswietlenie kolekcji w bazie 
show collections

# Skasowanie kolekcji 
db.Samoloty_czolgi.drop()

#   ====== Import kontrole do nowej bazy --> Cwiczenie4.js   +  przelaczenie 
# sie na nowa baze 
db.kontrole.find().pretty()

# Znalezienie dokumentow gdzie wynik kontroli == true
db.kontrole.find({"wynik_kontroli":"true"})

# Znalezienie dokumentow gdzie imie straznika  == Tomasz
db.kontrole.find({"straznik.imie":"Tomasz"})

# ..gdzie czas kontroli mniejszy od 50
db.kontrole.find({"czas_kontroli":{$lt:50}})

# ..gdzie czas kontroli wiekszy od 50
db.kontrole.find({"czas_kontroli":{$gt:50}})

# ..gdzie czas kontroli rozny od 78
db.kontrole.find({"czas_kontroli":{$ne:78}})

# wyszukanie z AND
db.kontrole.find( {  $and:[
                              {"straznik.imie":"Tomasz"},  
                              {"pasazer.imie": "Jan"}
                             ]
                    })
                    
# wyszukanie z OR
db.kontrole.find ({  $or:[
                          {"straznik.imie": "Tomasz"},                    
                          {"straznik.imie": "Jan"}
                         ]
                 })
                 
#Przykład AND oraz OR
 db.kontrole.find({
                    $and:[   {"czas_kontroli":{$gt:70}},
                             {$or:[
                                   {"straznik.imie":"Tomasz"},
                                   {"straznik.imie": "Jan"}
                                ]
                             }
                        ]
                  })
# Sprawdzenie czy jest wartość null albo nie ma takiego pola
db.kontrole.insert( {"ocena": null } )
db.kontrole.find( {"ocena": null } )

# Sprawdzenie gdzie nie ma pola ocena (ale nie null)
db.kontrole.find( {"ocena": { $exists: false } } )

# Uzycie kursora 
var kursorKontrole = db.kontrole.find( { czas_kontroli : { $gt:2 }});
while(kursorKontrole.hasNext()) { 
 print(tojson(kursorKontrole.next()));
}
#  Replace
db.kontrole.find({"test" :  23})
db.kontrole.replaceOne({"nazwa_portu" :  "Warszawa" }, {"test":23})
db.kontrole.find({"test" :  23})

# Update many
db.kontrole.updateMany(
         {"pasazer.imie": "Jan"}, 
         {$set:{"czas_kontroli":23}}
)
db.kontrole.find({"pasazer.imie": "Jan"})

# Bardziej złożony udpate
db.kontrole.updateMany(
              {$and:[
                        {"straznik.imie":"Tomasz"},
                        {"pasazer.imie": "Jan"}
                        ]}, 
              {$set:{"czas_kontroli":21}}
      )
db.kontrole.find({$and:[{"straznik.imie":"Tomasz"},{"pasazer.imie": "Jan"}]}).pretty()

# Kasowanie
db.kontrole.find({"pasazer.imie" : "Jan"})       
db.kontrole.remove({"pasazer.imie" : "Jan"})
db.kontrole.find({"pasazer.imie" : "Jan"}).pretty()

# Przyklad projections wyswietlenie KEY + nazwa_portu
db.kontrole.find({"pasazer.imie":"Stanislaw"},{"KEY":1,"nazwa_portu":1})

# Tworzenie indeksu
db.kontrole.createIndex({"pasazer.imie":1}) 

# ============= PRZELADOWAC BAZE ==============

# Agregacje 
SELECT nazwa_portu, sum(czas_kontroli) FROM kontrole GROUP BY nazwa_portu
db.kontrole.aggregate(
                     [
                       {$group : {_id : "$nazwa_portu", total: {$sum : "$czas_kontroli"}}}
                     ])
                       
# Agregacja ale dla kontoli innych niz Warszawa
db.kontrole.aggregate(
[  
      {$match: { nazwa_portu : {$ne: "Warszawa"}}},
      {$group : {_id : "$nazwa_portu", total: {$sum : "$czas_kontroli"}}}
])  
      
# Sortowanie po porcie
db.kontrole.find().sort({"nazwa_portu":1})

# Sortowanie po porcie rosnąco a po czasie kontroli malejąco
db.kontrole.find().sort({"nazwa_portu":1, "czas_kontroli":-1})


# Zapytanie z limit
db.kontrole.find().sort({data_kontroli:1}).limit(3)

# Przeskakiwanie
db.kontrole.find().sort({data_kontroli:1}).skip(1)

# Limit+przeskakiwanie
db.kontrole.find().sort({data_kontroli:1}).skip(1).limit(2)

# ================== CWICZENIA 5 i 6

# Tworzenie użytkownika
db.createUser(
{	user: "straznik2",
	pwd: "password",

	roles:[{role: "dbAdmin" , db:"kontrole"}]})
        
./mongo kontrole -u straznik1 -p password
        
# Ćwiczenie: załóżenie użytkownika do wcześniej stworzonej bazy u przypisanie użytkownika do roli 'read'
        

