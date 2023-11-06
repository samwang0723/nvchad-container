# syntax=docker/dockerfile:1
# Use the latest alpine image as the base
FROM alpine:latest

RUN apk update
RUN apk add --no-cache tzdata
ENV TZ=Asia/Taipei

# Install required packages and setup environment
# Some lib like util-linux may not needed
# You can choose to install other dependency using command:
# apk add --no-cache ruby ruby-bundler ruby-dev ruby-rdoc ruby-irb
RUN apk add --no-cache bash gcompat git neovim ripgrep build-base wget curl \
    && apk add --no-cache nodejs npm lua5.4 luajit python3 py3-pip \
    && apk add --no-cache -U lldb lldb-dev py3-lldb musl-dev libgcc \
    && apk add --no-cache gcc libc-dev libressl-dev pkgconfig \
    && apk add --no-cache util-linux github-cli neofetch \
    && apk add --no-cache protobuf protobuf-dev zsh zsh-theme-powerlevel10k tmux

# copy customize settings
RUN git clone https://github.com/samwang0723/nvchad-container.git ~/.config/nvchad-container

# zsh configuration
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN mkdir -p ~/.local/share/zsh/plugins \
    && ln -s /usr/share/zsh/plugins/powerlevel10k ~/.local/share/zsh/plugins/

RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

RUN cp ~/.config/nvchad-container/env/.zshrc ~/.zshrc
RUN cp ~/.config/nvchad-container/env/profile /etc/profile

# tmux configuration
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
RUN cp ~/.config/nvchad-container/env/.tmux.conf ~/.tmux.conf

# rust configuration
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && source $HOME/.cargo/env \
    && rustup target add x86_64-unknown-linux-musl

RUN cp ~/.config/nvchad-container/env/root/.cargo/config.toml ~/.cargo/config.toml
ENV PATH /root/.cargo/bin:$PATH
RUN cargo install stylua

# golang configuration
RUN wget https://dl.google.com/go/go1.21.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.21.3.linux-amd64.tar.gz \
    && rm go1.21.3.linux-amd64.tar.gz

ENV GOPATH /home/workspace
ENV PATH /usr/local/go/bin:$PATH

RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

# Clone the NvChad repository
RUN git clone https://github.com/NvChad/NvChad ~/.config/nvim
RUN cp -R ~/.config/nvchad-container/custom ~/.config/nvim/lua/

# Install pre-commit
RUN pip3 install pre-commit

# Clean all caches
RUN apk cache clean && pip cache purge
RUN rm -Rf ~/.config/nvchad-container

# Set the working directory in the container
WORKDIR /home/workspace

# start zsh
CMD ["zsh"]
