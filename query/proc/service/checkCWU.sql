CREATE PROCEDURE checkCWU
(
	@PESEL CHAR(11),
	@response XML OUT
)
AS
BEGIN
	DECLARE
		@session_id VARCHAR(MAX),
		@token VARCHAR(MAX)

	DECLARE @request XML = 
		(SELECT [XML] FROM XMLTemplate WHERE 
			[Name] = 'executeService')

	DECLARE	@URL VARCHAR(MAX) = 
		(SELECT [Value] FROM ServiceConfig WHERE 
			[Param] = 'ServiceBroker_URL')


	EXEC [login] @session_id OUT, @token OUT

	SET @request.modify('
		insert attribute id {sql:variable("@session_id")} into
		(/*:Envelope/*:Header/*:session)[1]
	')

	SET @request.modify('
		insert attribute id {sql:variable("@token")} into
		(/*:Envelope/*:Header/*:authToken)[1]
	')

	SET @request.modify('
		insert text{sql:variable("@PESEL")} into
		(/*:Envelope/*:Body/*:executeService/*:payload/*:textload/*:status_cwu_pyt/*:numer_pesel)[1]
	')

	EXEC sendRequest @URL, @request, @response OUT

	EXEC logout @session_id, @token, NULL
END
