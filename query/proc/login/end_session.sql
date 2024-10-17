CREATE PROCEDURE endSession
AS
BEGIN
	DECLARE @session_id VARCHAR(MAX), @token VARCHAR(MAX)

	EXEC logout @session_id, @token, NULL

	UPDATE OperatorSession 
	SET [session_id] = NULL,
		[token] = NULL
END