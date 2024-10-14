CREATE TABLE ServiceConfig
(
	[Param] VARCHAR(255) NOT NULL UNIQUE,
	[Value] VARCHAR(MAX)
)

GO

INSERT INTO ServiceConfig VALUES 
	('Auth_URL', NULL),
	('ServiceBroker_URL', NULL),
	('OW_SWD_required', '01,04,05,06,08,09,11,12')
