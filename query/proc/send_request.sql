CREATE PROCEDURE sendRequest
(
	@URL VARCHAR(MAX),
	@request XML,
	@response XML OUT
)
AS
BEGIN
	DECLARE @obj int,
			@ret INT,
			@responseText VARCHAR(8000)
		

	EXEC @ret = sp_OACreate 'MSXML2.ServerXMLHttp', @obj OUT
	EXEC @ret = sp_OAMethod @obj, 'open', NULL, 'POST', @URL, false
	EXEC @ret = sp_OAMethod @obj, 'send', NULL, @request
	EXEC @ret = sp_OAGetProperty @obj, 'responseText', @responseText OUT
	SET @response = CONVERT(XML, @responseText)

	EXEC sp_OADestroy @obj
	RETURN @ret
END