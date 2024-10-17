CREATE FUNCTION checkSessionActive()
RETURNS BIT
AS BEGIN
	IF (SELECT [session_id] FROM OperatorSession) IS NOT NULL
		AND (SELECT [session_id] FROM OperatorSession) IS NOT NULL
			RETURN 1

	RETURN 0
END
