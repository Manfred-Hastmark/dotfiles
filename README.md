# Dotfiles

Hello! These are my personal dotfiles which I use on my day-to-day computer. I use [this](https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/)
install of [Debian](https://www.debian.org/) along with the [i3wm](https://i3wm.org/) window manager. I spend most
of my time programming in C++ thus most of my extensions are centered around that. As my terminal emulator I use [WezTerm](https://wezfurlong.org/wezterm/) and 
as my terminal multiplexer I use [tmux](https://github.com/tmux/tmux/wiki) and my shell of choice is [zsh](https://www.zsh.org/) with [Oh My ZSH!](https://ohmyz.sh/). 
My preferred editor is [neovim](https://neovim.io/) and I use [lazyvim](https://www.lazyvim.org/) as my plugin manager. In general
I preffer quite a simple setup.


## Installing

For convenience, I have created a bash script to install all dependencies and create all the necessary
symlinks to everything, hopefully it should just be a one liner to install my dotfiles.

```bash
bash install.sh [-Y]
```
