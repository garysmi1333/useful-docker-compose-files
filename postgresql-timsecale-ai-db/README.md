# Postgresql Timescale DB docker-compose.yml

Docker compose files for quickly setting up a Postgres TimescaleDB with read only replication and ai extensions:

### Extensions
timescaledb
vectorscale
ai


## primary

Creates a database called ai-test-db and an admin user
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

