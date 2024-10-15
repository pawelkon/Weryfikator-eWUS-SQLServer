CREATE PROCEDURE getLoginSession
(
@response XML,
@session VARCHAR(MAX) OUT,
@authToken VARCHAR(MAX) OUT
)
AS
BEGIN
	SET @session = @response.value('
		declare namespace soapenv="http://schemas.xmlsoap.org/soap/envelope/";
		declare namespace ns1="http://xml.kamsoft.pl/ws/common";
		(/soapenv:Envelope/soapenv:Header/ns1:session/@id)[1]', 'varchar(max)')

	SET @authToken = @response.value('
		declare namespace soapenv="http://schemas.xmlsoap.org/soap/envelope/";
		declare namespace ns1="http://xml.kamsoft.pl/ws/common";
		(/soapenv:Envelope/soapenv:Header/ns1:authToken/@id)[1]', 'varchar(max)')

	IF (@session IS NULL) OR (@authToken IS NULL)
		RETURN -1

	RETURN 0
END