##!/bin/bash

# Defaults
readonly DIR_PM_VOL="$HOME/.pv"
readonly DIR_PG_VOL="$DIR_PM_VOL/pg"
readonly DIR_PG_D01="$DIR_PG_VOL/$(date +%s%3N)"

# Go to home folder
cd "$HOME"

# Create data directory
echo -e "Installing PostgreSQL server as podman container.."
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

## Pull images
echo -e "\nPulling latest official PostgreSQl image.."
podman pull docker.io/library/postgres:latest

echo -e "\nPulling latest official PgAdmin image.."
podman pull docker.io/dpage/pgadmin4:latest

echo -e "\nList of local podman images:"
podman images

# Create container
echo -e "\nCreating PostgreSQl container.."
podman create --name postgres \
	-p 5432:5432 \
	-e POSTGRES_PASSWORD=vRU-qY4-ck6-GaL \
	-v "$DIR_PG_D01":/var/lib/postgresql/data:Z \
	postgres:latest

## Run container
echo -e "\nStarting PostgreSQl container.."
podman start postgres
