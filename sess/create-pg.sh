##!/bin/bash

# Go to home folder
cd "$HOME"

echo ""
echo -e "==================================="
echo -e "\tPostgreSQL CCS"
echo -e "===================================\n"

pgContainerExists=$(podman container exists postgres ; echo $?)

if [ $pgContainerExists == 0 ]; then
	echo -e "Container postgres exists already!\n"
	podman ps -f name=postgres
	echo -e "\nInstallation aborted!"
	exit
fi

pgAdminExists=$(podman container exists pgadmin ; echo $?)

if [ $pgAdminExists == 0 ]; then
	echo "Container pgadmin exists already!\n"
	podman ps -f name=pgadmin
	echo -e "\nInstallation aborted!"
	exit
fi

## Pull images
echo -e "\nPulling latest official PostgreSQl image.."
podman pull docker.io/library/postgres:latest

echo -e "\nPulling latest official PgAdmin image.."
podman pull docker.io/dpage/pgadmin4:latest

echo -e "\nList of local podman images:"
podman images

echo ""
read -p "Enter password for new PostgreSQL server: " -s userProvidedPSQLPswd

# Create container
echo -e "\nCreating PostgreSQl container.."
podman create \
	--name postgres \
	-p 5432:5432 \
	-e POSTGRES_PASSWORD=$userProvidedPSQLPswd \
	postgres:latest

unset userProvidedPSQLPswd

## Run container
echo -e "\nStarting PostgreSQl container.."
podman start postgres

echo -e "\nStatus of postgres:"
podman ps -f name=postgres


echo -e "\Please provide data for PgAdmin server administrator.."

echo ""
read -p "E-mail : " userProvidedPgAdminEmail
read -p "Password : " -s userProvidedPgAdminLPswd

# Create container
echo -e "\nCreating PgAdmin container.."
podman create \
	--name pgadmin \
	-p 9180:80 \
	-p 9183:443 \
	-e PGADMIN_DEFAULT_EMAIL=$userProvidedPgAdminEmail \
	-e PGADMIN_DEFAULT_PASSWORD=$userProvidedPgAdminLPswd \
	pgadmin4:latest

## Run container
echo -e "\nStarting PgAdmin container.."
podman start pgadmin

echo -e "\nStatus of pgadmin4:"
podman ps -f name=pgadmin
