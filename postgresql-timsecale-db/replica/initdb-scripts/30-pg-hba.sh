#!/usr/bin/env bash
set -euo pipefail

# This runs after initdb, only on first container initialization.
PGDATA="${PGDATA:-/var/lib/postgresql/data}"

# Ensure remote password connections for clients and replication user (SCRAM-SHA-256)
cat >> "${PGDATA}/pg_hba.conf" <<'EOF'

# Allow password auth for all clients (adjust CIDR for your network)
host    all         all             0.0.0.0/0               scram-sha-256
EOF