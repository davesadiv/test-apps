/* SECURITY SCAN TEST FILE 
   PURPOSE: Testing Cortex CLI / Static Analysis detection
   WARNING: Do not run this on a production database.
*/

-- 1. Risky Stored Procedure (Dynamic SQL Injection Pattern)
-- Scanners should flag the use of EXECUTE with string concatenation.
CREATE OR REPLACE PROCEDURE find_user_danger(p_input TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- This is a classic injection pattern that scanners look for
    EXECUTE 'SELECT * FROM users WHERE username = ''' || p_input || '''';
END;
$$;

-- 2. Dangerous SQL Server System Procedure
-- Patterns like xp_cmdshell are highly suspicious and usually flagged immediately.
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- 3. Hardcoded Credentials Pattern
-- Scanners check for keywords like 'PASSWORD' or 'SECRET' followed by strings.
CREATE USER audit_svc WITH PASSWORD 'TemporaryPassword123!';

-- 4. Over-privileged Permissions
-- Granting ALL or Superuser rights to a generic user is a configuration risk.
GRANT ALL PRIVILEGES ON DATABASE security_test TO audit_svc;
ALTER USER audit_svc WITH SUPERUSER;

-- 5. Data Exfiltration/Information Disclosure Pattern
-- Querying system tables or information_schema in unusual ways.
SELECT name, password_hash FROM sys.sql_logins;
SELECT * FROM information_schema.tables;
