USE [AdventureWorks2012]
GO

CREATE TABLE [dbo].LOGS(
id int,
FileFullParh NVARCHAR(100),
CreationTime DATETIME);

SELECT * FROM [dbo].LOGS;

DROP TABLE [dbo].LOGS;


