CREATE PROCEDURE prepareLoginRequest
(
@id_OW CHAR(2), 
@login VARCHAR(MAX), 
@pass VARCHAR(MAX),
@requst XML OUT
)
AS
BEGIN
	SET @requst.modify('
		declare namespace soapenv="http://schemas.xmlsoap.org/soap/envelope/";
		declare namespace auth="http://xml.kamsoft.pl/ws/kaas/login_types";
	
		insert text{sql:variable("@id_OW")} into
		(/soapenv:Envelope/soapenv:Body/auth:login/auth:credentials/auth:item/auth:value/auth:stringValue)[1]
	')

	SET @requst.modify('
		declare namespace soapenv="http://schemas.xmlsoap.org/soap/envelope/";
		declare namespace auth="http://xml.kamsoft.pl/ws/kaas/login_types";
	
		insert text{sql:variable("@login")} into
		(/soapenv:Envelope/soapenv:Body/auth:login/auth:credentials/auth:item/auth:value/auth:stringValue)[2]
	')

	SET @requst.modify('
		declare namespace soapenv="http://schemas.xmlsoap.org/soap/envelope/";
		declare namespace auth="http://xml.kamsoft.pl/ws/kaas/login_types";
	
		insert text{sql:variable("@pass")} into
		(/soapenv:Envelope/soapenv:Body/auth:login/auth:password)[1]
	')
END