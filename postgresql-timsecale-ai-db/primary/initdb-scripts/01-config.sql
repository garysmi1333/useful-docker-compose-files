
-- Ensure SCRAM is used for new passwords
ALTER SYSTEM SET password_encryption = 'scram-sha-256';

-- Allow remote connections
ALTER SYSTEM SET listen_addresses = '*';

-- Optional: preload TimescaleDB
ALTER SYSTEM SET shared_preload_libraries = 'timescaledb';
