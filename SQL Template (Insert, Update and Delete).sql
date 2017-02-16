
----------------------------------------------------------------------------------------------------------------------------------
--	Title: SQL Templates for Database Management																				--
--	Author : Andre Barnard																										--		
--	Created on : 07 Febuary 2017																								--
--	Description : Template SQL queries to assist Developers when creating scripts for new development							--
--																																--
----------------------------------------------------------------------------------------------------------------------------------

--Adding new table query will check if table already exists before creating table

--Please remeber to UPDATE the Table name in the Select statment below.
Begin Tran
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'TableName')
	BEGIN
	--BEGIN - Replace part with your Create table Query

		CREATE TABLE [dbo].[TableName](
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[CreatedOn] [datetime] NOT NULL,
		[INTColumn] [int] NOT NULL,
		[STRINGColumn] [nvarchar](50) NULL,
	 CONSTRAINT [PK_TableName] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	--END Replace part with your Create table Query
	END
ELSE
	BEGIN
		PRINT 'Table already Exists'
	END
COMMIT

--ALter Table Add new Column
BEGIN TRAN
IF NOT EXISTS(SELECT * FROM sys.columns  WHERE Name = N'columnName' AND Object_ID = Object_ID(N'tableName'))
	BEGIN
		ALTER TABLE [tablename] ADD [columnName] varchar(50)
	END
Else
	BEGIN
		PRINT 'Column already Exists'
	END
COMMIT

--ALter Table Drop Colum
BEGIN TRAN
IF EXISTS(SELECT * FROM sys.columns  WHERE Name = N'columnName' AND Object_ID = Object_ID(N'tableName'))
	BEGIN
		ALTER TABLE [tablename] DROP COLUMN [columnName]
	END
Else
	BEGIN
		PRINT 'Column already Exists'
	END
COMMIT


--ALter Table Rename column in table
BEGIN TRAN
IF EXISTS(SELECT * FROM sys.columns  WHERE Name = N'columnName' AND Object_ID = Object_ID(N'tableName'))
	BEGIN
		exec sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN'
	END
Else
	BEGIN
		PRINT 'Column already Exists'
	END
COMMIT

--Insert New Record check if exist with ID comparison

BEGIN TRAN
IF EXISTS (Select * from [TableName] where ID = 1)
	BEGIN
	 Insert into [TableName] ([INTColumn],[STRINGColumn]) values (1234,'ABCD')
	END
ELSE
	BEGIN
		PRINT 'Entry already Exists'
	END
COMMIT


--Insert New Record if exist with string comparison
BEGIN TRAN
IF EXISTS (Select * from [TableName] where [STRINGColumn] = 'ABCD')
	BEGIN
	 Insert into [TableName] ([INTColumn],[STRINGColumn]) values (1234,'ABCD')
	END
ELSE
	BEGIN
		PRINT 'Entry already Exists'
	END
COMMIT