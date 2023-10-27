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

    $ docker commit -a '{your_name}@gmail.com' -m 'NvChad remote dev container' {container_id} {your_repo}/nvchad-base:v1.0.1

Upload to docker repository (Optional)

    $ docker push {your_repo}/nvchad-base:v1.0.1

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
