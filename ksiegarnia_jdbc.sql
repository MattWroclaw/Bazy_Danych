CREATE DATABASE  IF NOT EXISTS `ksiegarnia` ;
USE `ksiegarnia`;

--
-- Table structure for table `uzytkownik`
--

DROP TABLE IF EXISTS `uzytkownik`;
CREATE TABLE `uzytkownik` (
                              `id` int(11) NOT NULL AUTO_INCREMENT,
                              `imie` varchar(45) DEFAULT NULL,
                              `nazwisko` varchar(45) DEFAULT NULL,
                              PRIMARY KEY (`id`)
);

--
-- Dumping data for table `uzytkownik`
--

LOCK TABLES `uzytkownik` WRITE;
INSERT INTO `uzytkownik` VALUES (1,'Jan','Kowalski'),(2,'Adam','Nowak'),(3,'Ewa','Konieczna'),(4,'Stanislaw','Antoniuk'),(5,'Stefan','Koziol'),(6,'Jan','Nowak'),(7,'Jan','Polak'),(8,'Jan','Dudek'),(9,'Jan','Wielki'),(10,'Jan','Wilki'),(16,'Jan','Nowak'),(17,'Jan','Polak'),(18,'Jan','Dudek'),(19,'Jan','Wielki'),(20,'Jan','Wilki'),(21,'Jan','Nowak'),(22,'Jan','Polak'),(23,'Jan','Dudek'),(24,'Jan','Wielki'),(25,'Jan','Wilki'),(26,'Jan','Nowak'),(27,'Jan','Polak'),(28,'Jan','Dudek'),(29,'Jan','Wielki'),(30,'Jan','Wilki');
UNLOCK TABLES;

--
-- Table structure for table `adres`
--

DROP TABLE IF EXISTS `adres`;
CREATE TABLE `adres` (
                         `id` int(11) NOT NULL AUTO_INCREMENT,
                         `ulica` varchar(45) DEFAULT NULL,
                         `nrdomu` varchar(45) DEFAULT NULL,
                         `nrmieszkania` varchar(45) DEFAULT NULL,
                         `kodpocztowy` varchar(6) DEFAULT NULL,
                         `miejscowosc` varchar(45) DEFAULT NULL,
                         `uzytkownik` int(11) DEFAULT NULL,
                         PRIMARY KEY (`id`),
                         KEY `FK_uzytkownikadres_idx` (`uzytkownik`),
                         CONSTRAINT `FK_uzytkownikadres` FOREIGN KEY (`uzytkownik`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--
-- Dumping data for table `adres`
--

LOCK TABLES `adres` WRITE;
INSERT INTO `adres` VALUES (1,'Grunwaldzka','1a','13','80-821','Gdansk',1),(2,'Piwna','34','2','80-213','Gdynia',2),(3,'Staromiejska','43a','2','23-423','Warszawa',3),(4,'Chmielna','23b','12','42-241','Poznan',4),(5,'Wlokniarzy','521','1','98-218','Katowice',5),(6,'Zwyciestwa','2',NULL,'83-213','Sopot',1),(7,'Zamkowa','2',NULL,'88-982','Krakow',5),(8,'Szeroka','23d','13','80-518','Gdansk',1);
UNLOCK TABLES;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
CREATE TABLE `autor` (
                         `id` int(11) NOT NULL AUTO_INCREMENT,
                         `imie` varchar(45) DEFAULT NULL,
                         `nazwisko` varchar(45) DEFAULT NULL,
                         PRIMARY KEY (`id`)
);

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
INSERT INTO `autor` VALUES (1,'Joshua','Bloch'),(2,'Cay S.','Horstmann'),(3,'Christian','Bauer'),(4,'Gavin','King'),(5,'Gary','Gregory'),(6,'Krzysztof','Rychlicki-Kicior');
UNLOCK TABLES;

--
-- Table structure for table `ksiazka`
--

DROP TABLE IF EXISTS `ksiazka`;
CREATE TABLE `ksiazka` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `tytul` varchar(500) DEFAULT NULL,
                           PRIMARY KEY (`id`)
);

--
-- Dumping data for table `ksiazka`
--

LOCK TABLES `ksiazka` WRITE;
INSERT INTO `ksiazka` VALUES (1,'Java. Efektywne programowanie. Wydanie III'),(2,'Java. Efektywne programowanie. Wydanie II'),(3,'Java. Efektywne programowanie. Wydanie I'),(4,'Java. Techniki zaawansowane.'),(5,'Java 8. Przewodnik doswiadczonego programisty'),(6,'Java Persistence. Programowanie aplikacji bazodanowych w Hibernate. '),(7,'Hibernate w akcji'),(8,'Java EE 6. Programowanie aplikacji WWW'),(9,'Java 9. Przewodnik doswiadczonego programisty');
UNLOCK TABLES;
--
-- Table structure for table `autor_ksiazka`
--

DROP TABLE IF EXISTS `autor_ksiazka`;
CREATE TABLE `autor_ksiazka` (
                                 `idautor` int(11) NOT NULL,
                                 `ksiazka` int(11) NOT NULL,
                                 UNIQUE KEY `u_autorksiazka` (`idautor`,`ksiazka`),
                                 KEY `fk_ksiazka_idx` (`ksiazka`),
                                 KEY `FK_autor_idx` (`idautor`),
                                 CONSTRAINT `FK_autor` FOREIGN KEY (`idautor`) REFERENCES `autor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
                                 CONSTRAINT `fk_ksiazka` FOREIGN KEY (`ksiazka`) REFERENCES `ksiazka` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--
-- Dumping data for table `autor_ksiazka`
--

LOCK TABLES `autor_ksiazka` WRITE;
INSERT INTO `autor_ksiazka` VALUES (1,1),(1,2),(1,3),(2,4),(2,5),(3,6),(4,6),(5,6),(3,7),(4,7),(6,8),(2,9);
UNLOCK TABLES;

--
-- Table structure for table `zakupy`
--

DROP TABLE IF EXISTS `zakupy`;
CREATE TABLE `zakupy` (
                          `iduzytkownik` int(11) NOT NULL,
                          `idksiazki` int(11) NOT NULL,
                          KEY `FK_uzytkownik_idx` (`iduzytkownik`),
                          KEY `FK_ksiazka_idx` (`idksiazki`),
                          CONSTRAINT `FK_ksiazkazakupy` FOREIGN KEY (`idksiazki`) REFERENCES `ksiazka` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
                          CONSTRAINT `FK_uzytkownik` FOREIGN KEY (`iduzytkownik`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--
-- Dumping data for table `zakupy`
--

LOCK TABLES `zakupy` WRITE;
INSERT INTO `zakupy` VALUES (1,1),(1,4),(1,5),(2,2),(3,3),(4,5),(4,6),(5,7),(4,8),(5,9),(4,9),(3,4),(3,4),(3,4),(3,4);
UNLOCK TABLES;
