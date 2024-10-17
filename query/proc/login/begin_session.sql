CREATE PROCEDURE beginSession
AS
BEGIN
	DECLARE @session_id VARCHAR(MAX), @token VARCHAR(MAX)

	EXEC [login] @session_id OUT, @token OUT

	UPDATE OperatorSession 
	SET [session_id] = @session_id,
		[token] = @token
END

