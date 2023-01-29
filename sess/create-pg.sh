##!/bin/bash

# Defaults
readonly DIR_PM_VOL="$HOME/.pv"
readonly DIR_PG_VOL="$DIR_PM_VOL/pg"
readonly DIR_PG_D01="$DIR_PM_VOL/pg"

echo "Installing PostgreSQL server as podmain container.."
echo "You are running this script as $USER"

echo "Creating directory for podman volumes.."
mkdir -p "$DIR_PM_VOL"
touch "$DIR_PM_VOL/-directory-of-podman-volumes"

echo "Creating directory for postgres volumes.."
mkdir -p "$DIR_PG_VOL"
touch -e "$DIR_PG_VOL/-directory-of-postgres-volumes"

echo "Creating directory for postgres data.."
mkdir -p "$DIR_PG_D01"
echo "For data volume is used dir '$DIR_PG_D01'"
touch -e "$DIR_PG_D01/-directory-of-postgres-data"

echo "Pulling latest official PostgreSQl image"
podman pull docker.io/library/postgres:latest

echo "Pulling latest official PgAdmin image"
podman pull docker.io/dpage/pgadmin4:latest
