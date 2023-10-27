#!/bin/sh

if ! docker container inspect nvchad-container-v1 >/dev/null 2>&1; then
	# Create container from customized image
	docker run -it --platform linux/amd64 --cpus 2 -v .:/workspace --name nvchad-container-v1 samwang0723/nvchad-base:v1.0.1 /bin/bash '-l'
else
	# Start the container
	docker start nvchad-container-v1
	# Set container CPU
	docker update --cpus 2 nvchad-container-v1
	# Attach to the container
	docker exec -it nvchad-container-v1 bash '-l'
fi
