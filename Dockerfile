# syntax=docker/dockerfile:1
# Use the latest alpine image as the base
FROM alpine:latest

RUN apk update
RUN apk add --no-cache tzdata
ENV TZ=Asia/Taipei

# Install required packages and setup environment
# Some lib like util-linux may not needed
# You can choose to install other dependency using command:
# apk add --no-cache ruby ruby-bundler ruby-dev ruby-rdoc ruby-irb github-cli util-linux
RUN apk add --no-cache bash gcompat git neovim ripgrep build-base wget curl \
    && apk add --no-cache nodejs npm lua5.4 luajit python3 py3-pip \
    && apk add --no-cache go

# Clone the NvChad repository
RUN git clone https://github.com/NvChad/NvChad ~/.config/nvim

# Set the working directory in the container
WORKDIR /workspace

