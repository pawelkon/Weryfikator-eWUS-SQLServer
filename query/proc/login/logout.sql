CREATE PROCEDURE logout
(
	@session_id VARCHAR(MAX),
	@auth_token VARCHAR(MAX),
	@response XML OUT
)
AS
BEGIN
	DECLARE @URL VARCHAR(MAX) = 
		(SELECT Value FROM ServiceConfig WHERE Param = 'Auth_URL')

	DECLARE @request XML = 
		(SELECT XML FROM XMLTemplate WHERE Name = 'logout')

	EXEC sendLogoutRequest @URL, @session_id, @auth_token,
		@request, @response OUT
END
