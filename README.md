# Weryfikator eWUŚ (SQL Server)
Implementacja komunikacji z portalem eWUŚ poprzez Web Service dla SQL Server. 
Rozwiązanie pozwala na weryfikację uprawnień świadczeniobiorców bezpośrednio przez serwer bazy danych.

## Instalacja
Plik z bazą danych (EwusVerificator), potrzebną do instalacji i konfiguracji, znajduje się w:

#### 1. Konfiguracja serwera SQL
Weryfikator do działania wymaga włączenia opcji 'Ole Automation Procedures' na serwerze SQL.\
Skrypt do aktywacji:
```
sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'Ole Automation Procedures', 1;  
GO  
RECONFIGURE;  
GO
```
#### 2. konfiguracja operatora
W tabeli OperatorConfig należy wpisać dane konta w systemie NFZ, które będzie używane do autoryzacji.\
Parametry:\
**login** - login operatora\
**password** - hasło operatora (**hasło jest przechowywane w formie niezaszyfrowanej**)\
**id_OW** - dwucyfrowy numer oddziału NFZ\
**id_SWD** - identyfikator świadczeniodawcy (wymagane jeżeli id_OW został ustawiony na 01, 04, 05, 06, 08, 09, 11 lub 12)
