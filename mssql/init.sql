IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'developer')
BEGIN
    CREATE LOGIN developer WITH PASSWORD = 'Puppy.1518', CHECK_POLICY = OFF;
    ALTER SERVER ROLE sysadmin ADD MEMBER developer;
END
GO
