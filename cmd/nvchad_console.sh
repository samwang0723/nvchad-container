#!/bin/sh

if ! docker container inspect nvchad-container-v1 >/dev/null 2>&1; then
	docker volume create nvchad-volume
	# Create container from customized image, if not installed the zsh, please use bash '-l'
	docker run -it --platform linux/amd64 --cpus 2 -v nvchad-volume:/workspace --name nvchad-container-v1 samwang0723/nvchad-base:v1.3.0 zsh
else
	# Start the container
	docker start nvchad-container-v1
	# Set container CPU
	docker update --cpus 2 nvchad-container-v1
	# Attach to the container, if not installed the zsh, please use bash '-l'
	docker exec -it nvchad-container-v1 zsh
fi
