#!/bin/sh

if ! docker container inspect nvchad-container >/dev/null 2>&1; then
	docker volume create nvchad-volume
	# Create container from customized image, if not installed the zsh, please use bash '-l'
	docker run -it --platform linux/amd64 --cpus 2 -v nvchad-volume:/workspace --network=host --name nvchad-container samwang0723/nvchad-base:v1.4.0 zsh
else
	# Start the container
	docker start nvchad-container
	# Set container CPU
	docker update --cpus 2 nvchad-container
	# Attach to the container, if not installed the zsh, please use bash '-l'
	docker exec -it nvchad-container zsh
fi
