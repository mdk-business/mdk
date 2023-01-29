##!/bin/bash

# Defaults
readonly DIR_PM_VOL="$HOME/.pv"
readonly DIR_PG_VOL="$DIR_PM_VOL/pg"
readonly DIR_PG_D01="$DIR_PM_VOL/pg"

echo -e "Installing PostgreSQL server as podmain container.."
echo -e "You are running this script as $USER"

echo -e "\nCreating directory for podman volumes.."
mkdir -p "$DIR_PM_VOL"
touch "$DIR_PM_VOL/-directory-of-podman-volumes"

echo -e "\nCreating directory for postgres volumes.."
mkdir -p "$DIR_PG_VOL"
touch "$DIR_PG_VOL/-directory-of-postgres-volumes"

echo -e "\nCreating directory for postgres data.."
mkdir -p "$DIR_PG_D01"
echo -e "For data volume is used dir '$DIR_PG_D01'"
touch "$DIR_PG_D01/-directory-of-postgres-data"

echo -e "\nPulling latest official PostgreSQl image"
podman pull docker.io/library/postgres:latest

echo -e "\nPulling latest official PgAdmin image"
podman pull docker.io/dpage/pgadmin4:latest

echo -e "\nList of podman images:"
podman images
