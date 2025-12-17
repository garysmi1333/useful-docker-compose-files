#!/usr/bin/env bash
set -eu pipefail

DATA_DIR=/var/lib/postgresql/data

echo "Replica entrypoint starting..."

# Run base backup only if data dir is empty

if [ -z "$(ls -A "$DATA_DIR" 2>/dev/null)" ]; then
  echo "Replica: performing base backup from primary..."
  rm -rf "${DATA_DIR:?}"/*


  PGPASSFILE=/var/lib/postgresql/.pgpass
  echo "${POSTGRES_PRIMARY_DB}:${POSTGRES_PRIMARY_DB_PORT}:replication:replicator:${REPLICA_PASSWORD}" > "$PGPASSFILE"
  chown postgres:postgres "$PGPASSFILE" || true
  chmod 600 "$PGPASSFILE"
  export PGPASSFILE

  pg_basebackup \
    -h ${POSTGRES_PRIMARY_DB} \
    -p ${POSTGRES_PRIMARY_DB_PORT} \
    -U replicator \
    -D "$DATA_DIR" \
    -X stream \
    -P \
    -R
else
  echo "Replica: data directory already present, starting streaming..."
fi

# Ensure data dir ownership
chown -R postgres:postgres "$DATA_DIR"

echo "Starting postgres..."
exec /usr/local/bin/docker-entrypoint.sh postgres \
  -c listen_addresses='*' \
  -c hot_standby=on \
  -c shared_preload_libraries=timescaledb \
  -c wal_level=replica 