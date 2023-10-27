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
	# After setup all environment, you can commit into a new image
	# docker commit -a 'sam.wang.0723@gmail.com' -m 'NvChad cloud container'  3779db8b72ac nvchad-base:v2
	# docker tag nvchad-base:v2 samwang0723/nvchad-base:v2
	# docker run -it -v .:/workspace --name nvchad-container-v2 nvchad-base:v2 /bin/bash '-l'

	# If the image already exists, just run it
	docker start nvchad-container-v2
	docker update --cpus 2 nvchad-container-v2
	docker exec -it nvchad-container-v2 bash '-l'
fi

# Rust configuration
# apk del rust
# apk del cargo
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# apk add lldb
# apk add lldb-dev
# rustup target list --installed
# rustup target add x86_64-unknown-linux-musl
# apk add --no-cache -U musl-dev
# apk add -U --no-cache libgcc
