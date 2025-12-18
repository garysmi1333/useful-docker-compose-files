
-- 1) database + role
CREATE DATABASE "ai-test-db";

CREATE ROLE dev WITH
  LOGIN
  ENCRYPTED PASSWORD 'password';

-- Make dev the owner (lets the role manage objects in this DB)
ALTER DATABASE "ai-test-db" OWNER TO dev;

-- 2) connect into the new DB to install extensions there
\connect "ai-test-db"

-- (Optional safety if the image already adds TimescaleDB)
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- pgvectorscale (extension name is 'vectorscale'); CASCADE installs pgvector if needed
CREATE EXTENSION IF NOT EXISTS vectorscale CASCADE;

-- pgai (extension name is 'ai'); CASCADE installs dependencies like 'vector' and 'plpython3u' when available
CREATE EXTENSION IF NOT EXISTS ai CASCADE;

-- 3) grant privileges to dev
GRANT ALL PRIVILEGES ON DATABASE "ai-test-db" TO dev;
GRANT USAGE ON SCHEMA public TO dev;

-- Future tables in public: grant dev privileges by default (handy for app dev)
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO dev;

