#!/bin/sh

# Check if the Docker image already exists
if ! docker image inspect nvchad-base >/dev/null 2>&1; then
	# If the image doesn't exist, build it
	docker pull --platform linux/amd64 alpine:latest

	# Need to setup multi-arch build environment at first time
	# docker buildx create --use
	docker buildx build --load --platform=linux/amd64 -t nvchad-base -f Dockerfile .
	docker volume create nvchad-volume

	# Run the Docker container with a persistent volume
	docker run -it -v nvchad-volume:/workspace --name nvchad-container nvchad-base /bin/bash

	# After launched, you will find Mason install some packages failed, you can install them manually.
	# :MasonInstall --target=linux_x64_gnu {package}
	# If package still not able to install like stylua, you can install it manually.
	# cargo install stylua
else
	# If the image already exists, just run it
	docker start nvchad-container
	docker exec -it nvchad-container bash
fi
