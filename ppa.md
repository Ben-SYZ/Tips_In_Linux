# personal package achieve

## find package
[https://launchpad.net](https://launchpad.net)

## add ppa to my repository

```sh
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
```

There will be signing key when adding ppa to your repository, to verify it.

The command above add the following 2 to `/etc/apt/sources.list.d/neovim-ppa-ubuntu-stable-bionic.list`

```sh
deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu bionic main
deb-src http://ppa.launchpad.net/neovim-ppa/stable/ubuntu bionic main
```

