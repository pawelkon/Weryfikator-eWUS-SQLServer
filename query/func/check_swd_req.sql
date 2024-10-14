CREATE FUNCTION checkSWDReq()
RETURNS CHAR(2)
AS
BEGIN
	RETURN (SELECT Value FROM OperatorConfig 
			WHERE Param = 'id_OW' 
			AND Value IN 
				( SELECT * FROM STRING_SPLIT ( 
					(SELECT Value FROM ServiceConfig 
						WHERE Param = 'OW_SWD_required'), ',')))
END
