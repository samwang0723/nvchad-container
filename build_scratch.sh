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
fi
