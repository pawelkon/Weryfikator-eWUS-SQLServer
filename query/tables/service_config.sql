CREATE TABLE ServiceConfig
(
	[Param] VARCHAR(255) NOT NULL UNIQUE,
	[Value] VARCHAR(MAX)
)

GO

INSERT INTO ServiceConfig VALUES 
	('Auth_URL', NULL),
	('ServiceBroker_URL', NULL)
