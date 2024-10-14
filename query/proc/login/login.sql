CREATE PROCEDURE [login]
(
	@session_id VARCHAR(MAX) OUT,
	@auth_token VARCHAR(MAX) OUT
)
AS
BEGIN
	DECLARE @URL VARCHAR(MAX) = 
		(SELECT Value FROM ServiceConfig WHERE Param = 'Auth_URL')

	DECLARE @id_OW VARCHAR(MAX) = 
		(SELECT Value FROM OperatorConfig WHERE Param = 'id_OW')
	DECLARE @login VARCHAR(MAX) = 
		(SELECT Value FROM OperatorConfig WHERE Param = 'login')
	DECLARE @pass VARCHAR(MAX) = 
		(SELECT Value FROM OperatorConfig WHERE Param = 'pass')

	DECLARE @request XML = 
		(SELECT XML FROM XMLTemplate WHERE Name = 'login')
	DECLARE @response XML

	EXEC sendLoginRequest @URL, @id_OW, @login, @pass, @request, @response OUT

	EXEC getLoginSession @response, @session_id OUT, @auth_token OUT
END
