# Postgresql Timescale DB docker-compose.yml

Docker compose files for quickly setting up a Postgres TimescaleDB with read only replication and ai extensions:

### Extensions
timescaledb
vectorscale
ai

# Local Storage
If using as is, it uses local bind mounts for persistent storage, before first run:

```
mkdir primary/postgres_primary_data
chown 1000:1000 primary/postgres_primary_data

mkdir replica/postgres_replica_data
chown 1000:1000 replica/postgres_replica_data
```

# Docker network
To use the default network used by the primary and replica

```
docker network create development-network
```

## primary

Creates a database called development and an admin user
user: dev
password: password

```
cd primary
docker compose up -d
```
A an instance will be started up listening on port 5432


### replica

```
cd replica
docker compose up -d
```

The read only replication database started up listening on port 5433


### Variables
See the docker-compose.yml files for default values i.e. ```POSTGRES_USER POSTGRES_PASSWORD``` etc.

To change replica_password modify ```primary/initdb-scripts/20-replication-user.sql```  and 

