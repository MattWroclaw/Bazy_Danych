Filmy24h
Należy stworzyć bazę danych (tablicę, ograniczenia, indeksy) oraz najczęściej używane zapytania, które będą używane przez część Java dla serwisu opisanego poniżej. 
Główną usługa serwisu Filmy24h jest możliwość pobierania plików MP4 z filmami w ramach opłaty miesięczne.
Byty
Zarejestrowany użytkownik serwisu – osoba, która ma założone konto w serwisie i która może pobierać filmy z serwisu.
Film – plik MP4 leżący na serwerze Apacha pod określonym linkiem. Film jest opisany takimi danymi jak: tytuł, rok produkcji, reżyser, aktorzy biorący udział w filmie, kategoria filmu
Konto finansowe – przechowuje informację jaki jest stan konta użytkownika.
Wpłata – powoduje dodanie kwoty do konta finansowego.
Obciążenie – wpis informujący o naliczeniu opłaty.
Typ abonamentu  – użytkownik może wybrać między dwoma typami abonamentu Standard/Premium. W standard może pobrać miesięcznie 10 a w premium 30 nowych filmów. Za standard obciążany jest  20zł/miesiąc, za premium 40zł/miesiąc.
Historia pobranych filmów – system przechowuje listę filmów które użytkownik wybrał w ramach abonamentu
Lista nowości – lista wyświetlająca ostatnio dodane filmy 
Znajomy – osoba do której wysłaliśmy zaproszenie w systemie i ona te zaproszenie potwierdziła. Jeśli ktoś jest znajomym możemy oglądać jakie filmy ta osoba oglądała.
Kategoria filmu – definiuje jakiego typu jest film. Oprócz nazwy kategoria zawiera dłuższy opis.

Przypadki użycia
Rejestracja osoby odwiedzającej strony w serwisie – w rezultacie zakładane jest konto użytkownika w serwisie 
Przeglądanie filmów – użytkownik może przeglądać opisy filmów używając różnych kryteriów sortowania i filtrowania
Pobranie filmu –  pobranie filmu czyli wyświetlenie użytkownikowi linku za pomocą którego może pobrać film. Wyświetlenie wybranego filmu (którego wcześniej nie wybrał)  powoduje zwiększenia licznika filmów pobranych w miesiącu.
Dokonanie wpłaty – realizowane przez wciśnięcie przycisku ‘Zapłać’  w interfejsie użytkownika i zainicjowanie procesu płatności przez zewnętrzny system. Zakładamy że baza dostaje informację jeśli udało się zrealizować płatność
Wyświetlenie nowości – system pozwoli na wyświetlenie nowości w systemie
Wyświetlenie historii pobranych filmów – system pozwoli na wyświetlenie pobranych filmów
Dodanie znajomości – polega na tym, że użytkownik podaje nazwę użytkownika i tej osobie wyświetla się informacja, że czeka na potwierdzenie zaproszenie. Jeśli Dwie osoby są znajomymi mogą oglądać przeglądać listę filmów które oglądały.
Naliczenie opłat – comiesięczna opercja obciążająca stan konta.
Skala działania 
Ilość filmów 50 tysięcy.
Ilość użytkowników 100 tysięcy, średnio jeden użytkownik ma 10-20 znajomych.
Użytkownik pobiera średnio 10-20 filmów miesięcznie. 
Ilość osób przeglądających równolegle listę filmów  50-100.