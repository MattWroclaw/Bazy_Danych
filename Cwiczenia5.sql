-- Ćwiczenie 5.1
-- Proszę utworzyć użytkownika  u1a z haslem abc i nadac uprawneinia do slectowania tablicy pasazer

-- DROP USER u1a;

CREATE USER 'u1a'@'localhost'   IDENTIFIED BY 'abc';
GRANT SELECT ON pasazer TO 'u1a'@'localhost';

-- Przyklad  uzycia GRANT do nadawania uprawnnien do UPDATE jednej kolumny
  CREATE USER 'u1b'@'lobcalhost' IDENTIFIED BY 'abc';
  GRANT UPDATE(pensja)  ON  straznik TO 'u1b'@'lobcalhost';
  GRANT SELECT ON straznik TO 'u1b'@'lobcalhost';

-- Przyklad - Widok z tylko z wybranymi danymi
  CREATE VIEW straznicy_A  AS 
  SELECT * FROM straznik WHERE nazwisko LIKE 'A%';

   CREATE USER 'u1c'@'lobcalhost' IDENTIFIED BY 'abc';
   GRANT SELECT ON  straznicy_A TO 'u1c'@'lobcalhost';

   REVOKE SELECT ON  straznicy_A FROM 'u1c'@'lobcalhost' ;