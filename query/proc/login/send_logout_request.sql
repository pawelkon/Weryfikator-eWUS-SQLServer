CREATE OR ALTER PROCEDURE sendLogoutRequest
(
	@URL VARCHAR(MAX),
	@session_id VARCHAR(MAX), 
	@token VARCHAR(MAX),
	@request XML,
	@response XML OUT
)
AS
BEGIN
	SET @request.modify('
		declare namespace soapenv="http://schemas.xmlsoap.org/soap/envelope/";
		declare namespace com="http://xml.kamsoft.pl/ws/common";
		
		insert attribute id {sql:variable("@session_id")}
		into
		(/soapenv:Envelope/soapenv:Header/com:session)[1]
		
		')

	SET @request.modify('
		declare namespace soapenv="http://schemas.xmlsoap.org/soap/envelope/";
		declare namespace com="http://xml.kamsoft.pl/ws/common";
		
		insert attribute id {sql:variable("@token")}
		into
		(/soapenv:Envelope/soapenv:Header/com:authToken)[1]
		
		')

	EXEC sendRequest @URL, @request, @response OUT
END