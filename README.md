# Weryfikator eWUŚ (SQL Server)
Implementacja komunikacji z portalem eWUŚ poprzez Web Service dla SQL Server. 
Rozwiązanie pozwala na weryfikację uprawnień świadczeniobiorców bezpośrednio przez serwer bazy danych.

## Instalacja
Plik EwusVerificator.bak zawiera bazę danych (EwusVerificator) gotową do konfiguracji i użycia.\
Bazę należy załadować z pliku do SQL Server przez "Restore Database..."\
W folderze **test** znajduje się skrypt do przetestowania poprawności konfiguracji i działania weryfikatora.

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
**pass** - hasło operatora (**hasło jest przechowywane w formie niezaszyfrowanej**)\
**id_OW** - dwucyfrowy numer oddziału NFZ\
**id_SWD** - identyfikator świadczeniodawcy (wymagany jeśli id_OW został ustawiony na 01, 04, 05, 06, 08, 09, 11 lub 12)

#### 3. konfiguracja usługi
W tabeli ServiceConfig należy wpisać adresy URL serwera autoryzacji i usługi.\
Parametry:\
**Auth_URL** - adres serwera autoryzacji\
**ServiceBroker_URL** - adres serwera usługi 

Aktualne adresy serwerów produkcyjnych: \
serwer autoryzacji: https://ewus.nfz.gov.pl/ws-broker-server-ewus/services/Auth \
serwer usługi: https://ewus.nfz.gov.pl/ws-broker-server-ewus/services/ServiceBroker 

Aktualne adresy testowych: \
serwer autoryzacji: https://ewus.nfz.gov.pl/ws-broker-server-ewus-auth-test/services/Auth \
serwer usługi: https://ewus.nfz.gov.pl/ws-broker-server-ewus-auth-test/services/ServiceBroker


## Używanie weryfikatora
Do weryfikacji pojedynczej osoby w systemie eWUŚ służy procedura **CheckCWU**, która przyjmuje dwa parametry: numer pesel w formie tekstowej oraz zmienną typu XML do zapisu informacji zwrotnej. Przed wywołaniem procedury CheckCWU należy rozpocząć sesję poprzez wywołanie procedury **BeginSession** (nie przyjmuje parametrów), a po zakończeniu sprawdzania ostatniej osoby, należy zakończyć sesję przez wywołanie **EndSession** (nie przyjmuje parametrów).\
*Przykład:* \
```
DECLARE @response XML
EXEC BeginSession
EXEC checkCWU '79060804378', @response OUT
EXEC EndSession
```
