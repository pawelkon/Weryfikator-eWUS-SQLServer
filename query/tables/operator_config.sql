CREATE TABLE OperatorConfig
(
	[Param] VARCHAR(255) NOT NULL UNIQUE,
	[Value] VARCHAR(MAX)
)

GO

INSERT INTO OperatorConfig VALUES
	('login', NULL), 
	('password', NULL),
	('id_OW', NULL)
