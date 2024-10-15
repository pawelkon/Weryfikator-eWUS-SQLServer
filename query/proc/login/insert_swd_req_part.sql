CREATE PROCEDURE insertSWDReqPart
(
	@request XML OUT
)
AS
BEGIN
	DECLARE @swd_part XML = 
		(SELECT [XML] FROM XMLTemplate WHERE [Name] = 'login_swd_part')

	DECLARE @id_SWD VARCHAR(MAX) = 
		(SELECT [Value] FROM OperatorConfig WHERE [Param] = 'id_SWD')


	SET @request.modify('
		insert sql:variable("@swd_part") after
				(/*:Envelope/*:Body/*:login/*:credentials/*:item)[1]
	')

	SET @request.modify('
		insert text{sql:variable("@id_SWD")} into
				(/*:Envelope/*:Body/*:login/*:credentials/*:item/*:value/*:stringValue)[3]
	')
END
