UPDATE OperatorConfig
SET [Value] = 'TEST' WHERE [Param] = 'login'
UPDATE OperatorConfig
SET [Value] = 'qwerty!@#' WHERE [Param] = 'pass'
UPDATE OperatorConfig
SET [Value] = '01' WHERE [Param] = 'id_OW'
UPDATE OperatorConfig
SET [Value] = '123456789' WHERE [Param] = 'id_SWD'
----------------------------------------------------
UPDATE ServiceConfig
SET [Value] = 'https://ewus.nfz.gov.pl/ws-broker-server-ewus-auth-test/services/Auth' 
WHERE [Param] = 'Auth_URL'
UPDATE ServiceConfig
SET [Value] = 'https://ewus.nfz.gov.pl/ws-broker-server-ewus-auth-test/services/ServiceBroker' 
WHERE [Param] = 'ServiceBroker_URL'
----------------------------------------------------
DECLARE @pesele_testowe TABLE
(
	PESEL CHAR(11) NOT NULL,
	Response XML
)

INSERT INTO @pesele_testowe(PESEL) VALUES
('79060804378'),
('00081314722'),
('00032948271'),
('00102721595')


DECLARE @pesel CHAR(11),
	@response XML

DECLARE vend_cursor CURSOR
    FOR SELECT PESEL FROM @pesele_testowe

OPEN vend_cursor

FETCH NEXT FROM vend_cursor INTO @pesel

EXEC BeginSession

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC CheckCWU @pesel, @response OUT
	UPDATE @pesele_testowe SET Response = @response WHERE PESEL = @pesel


FETCH NEXT FROM vend_cursor INTO @pesel
END

EXEC EndSession

CLOSE vend_cursor
DEALLOCATE vend_cursor

SELECT * from @pesele_testowe