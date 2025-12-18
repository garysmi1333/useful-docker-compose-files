
-- /docker-entrypoint-initdb.d/20-replication-user.sql

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'replicator') THEN
    CREATE ROLE replicator
      WITH REPLICATION LOGIN PASSWORD 'replica_password';
  ELSE
    ALTER ROLE replicator PASSWORD 'replica_password';
  END IF;
END
$$ LANGUAGE plpgsql;
