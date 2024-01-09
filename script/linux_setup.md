# Linux System Setup
- __Description:__ set up linux environment
- __Author:__ Noah Lin
- __Contact:__ noah@c-link.com.tw
- __Date:__ 2024-01-09

# Table of Contents
1. [Admin (sudo)](#admin-(sudo))
   * [apt and essential packages](#apt-and-essential-packages)
   * [install neovim with snap](#install-neovim-with-snap)
2. [User](#user)
   * [switch user](#switch-user)
   * [install and symlink kitty](#install-and-symlink-kitty)
   * [starship](#starship)
   * [install and symlink fdfind and batcat](#install-and-symlink-fdfind-and-batcat)
   * [clone dotfiles and configs](#clone-dotfiles-and-configs)
   * [fzf](#fzf)
   * [miniconda](#miniconda)
   * [change login shell and install fisher plugins](#change-login-shell-and-install-fisher-plugins)
## Admin (sudo)

### apt and essential packages
```bash
apt-add-repository ppa:fish-shell/release-3 -y
apt update && apt upgrade -y
apt install nala
nala install fish ripgrep htop fd-find batcat trash-cli kitty-terminfo
```
### install neovim with snap
```bash
snap install nvim --classic
```
## User

### switch user
```bash
su $YOUR_USER_NAME
```
### install and symlink kitty
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/kitty
ln -s ~/.local/kitty.app/bin/kitten /usr/local/bin/kitten
```
### starship
```bash
curl -sS https://starship.rs/install.sh | sh
```
### install and symlink fdfind and batcat
```bash
ln -s $(which fdfind) ~/.local/bin/fd
ln -s $(which batcat) ~/.local/bin/bat
```
### clone dotfiles and configs
```bash
mkdir ~/repos
git clone http://github.com/popshia/dotfiles ~/repos/dotfiles
git clone http://github.com/popshia/nvim ~/.config/nvim
```
### fzf
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
### miniconda
```bash
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init fish
```
### change login shell and install fisher plugins
```bash
chsh -s /usr/bin/fish
fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install PatrickF1/fzf.fish \
	jhillyerd/plugin-git \
	jethrokuan/z \
	jorgebucaran/autopair.fish \
	nickeb96/puffer-fish
```
