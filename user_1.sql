-- Creates the login test with password 'test'.
CREATE LOGIN test WITH PASSWORD = 'test';
GO

-- Creates a database user for the login created above.
CREATE USER test FOR LOGIN test;
GO