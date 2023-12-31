# nvchad-container

This is a docker image based NvChad container, to achieve portable Neovim development experience.

## Initiaization

### Step 1. Build the image

You can build the base image and customize yourself

    $ ./build_scratch.sh

After build completed, it directly launches the bash console and you can type `nvim` to configure the NvChad.
Some setup video for reference: 

1. [Python configuration](https://www.youtube.com/watch?v=4BnVeOUeZxc&list=PL05iK6gnYad1sb4iQyqsim_Jc_peZdNXf&index=4)
2. [Golang configuration](https://www.youtube.com/watch?v=i04sSQjd-qo&list=PL05iK6gnYad1sb4iQyqsim_Jc_peZdNXf&index=3)
3. [Rust configuration](https://www.youtube.com/watch?v=mh_EJhH49Ms&list=PL05iK6gnYad1sb4iQyqsim_Jc_peZdNXf&index=2)
4. [ChatGPT configuration](https://www.youtube.com/watch?v=7k0KZsheLP4&list=PL05iK6gnYad1sb4iQyqsim_Jc_peZdNXf&index=5)

You may also configure the `/etc/profile` in case you want to include /bin from library or add alias, can refer to `profile` file in the repository

### Step 2. Wrap the customized container into a new image

If you have configured a satisified NvChad, now wrap it into a new image
Find the container ID

    $ docker container ls

Pack into a new image with version

    $ docker commit -a '{your_email}' -m 'NvChad remote dev container' {container_id} {your_repo}/nvchad-base:v1.3.0

Upload to docker repository (Optional)

    $ docker push {your_repo}/nvchad-base:v1.3.0

### Step 3. Enjoy the hacking

    $ ./nvchad_console.sh


## Additional

### Mason install

Mason could have problem finding correct build from your platform, consider add --target depends on your platform

    :MasonInstall --target=linux_x64_gnu {package}

If still failed, install manually

    $ cargo install stylua


### Rust configuration

Preparation to install rust development environment in the container

    $ apk add --no-cache -U lldb lldb-dev musl-dev libgcc
    $ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

Make sure rust/cargo build using correct target

    $ rustup target list --installed
    $ rustup target add x86_64-unknown-linux-musl

### Golang configuration

If default Alpine apk add go version not fit with your requirement

    $ apk del go

Download the binary manually

    $ wget https://dl.google.com/go/go1.21.3.linux-amd64.tar.gz
    $ tar -C /usr/local -xzf go1.21.3.linux-amd64.tar.gz

Change profile `$PATH`

    $ export PATH="$PATH:/usr/local/go/bin"
    $ source /etc/profile

### Store password securely (Optional, you may meet gpg issue)

You will need to install gpg and generate a gpg key

    $ apk add gpg gpg-agent
    $ gpg --full-generate-key
    $ gpg --list-keys

Once gpg key generated, we can start using password

    $ apk add pass
    $ pass init {gpg-key-id}
    $ pass insert {domain}/{pass-name}
    $ pass show {domain}/{pass-name}

### Oh-my-zsh

    $ apk add zsh
    $ vi /etc/passwd

Modify to be `root:x:0:0:root:/root:/bin/zsh`

    $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Highlighting

    $ cd $HOME/.oh-my-zsh/plugins
    $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    $ echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc

Autosuggestions

    $ cd $HOME/.oh-my-zsh/plugins
    $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

Add plugin

    plugins = (
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
        tmux
    )

### Tmux

https://dev.to/andrenbrandao/terminal-setup-with-zsh-tmux-dracula-theme-48lm

    $ apk add tmux
    $ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

Press `<prefix> + I` (capital i) to install it. The default <prefix> is `ctrl + b`, so press `ctrl + b + I`.
