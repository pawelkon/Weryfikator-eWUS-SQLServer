CREATE PROCEDURE sendLoginRequest
(
	@URL VARCHAR(MAX),
	@id_OW CHAR(2),
	@login VARCHAR(MAX), 
	@pass VARCHAR(MAX),
	@request XML,
	@response XML OUT
)
AS
BEGIN
	EXEC prepareLoginRequest @id_OW, @login, @pass, @request OUT

	EXEC sendRequest @URL, @request, @response OUT
END