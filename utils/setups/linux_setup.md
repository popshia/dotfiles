# Linux System Setup
- __Description:__ set up linux environment
- __Author:__ Noah Lin
- __Contact:__ noah@c-link.com.tw
- __Date:__ 2024-01-09

# Table of Contents
  * [apt and essential packages](#apt-and-essential-packages)
  * [install eza](#install-eza)
  * [install neovim with snap](#install-neovim-with-snap)
  * [install vivid](#install-vivid)
  * [run gogh to generate colorscheme](#run-gogh-to-generate-colorscheme)
  * [install and symlink kitty](#install-and-symlink-kitty)
  * [starship](#starship)
  * [install and symlink fd and bat](#install-and-symlink-fd-and-bat)
  * [clone dotfiles and configs](#clone-dotfiles-and-configs)
  * [nerdfont](#nerdfont)
  * [fzf](#fzf)
  * [miniconda](#miniconda)
  * [change login shell and install fisher plugins](#change-login-shell-and-install-fisher-plugins)
### apt and essential packages
```bash
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt update && apt upgrade -y
sudo apt install nala
sudo nala install -y fish ripgrep htop fd-find bat trash-cli kitty-terminfo ranger curl stow gpg
```
### install eza
```bash
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo nala update
sudo nala install -y eza
```
### install neovim with snap
```bash
snap install nvim --classic
```
### install vivid
```bash
wget "https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb"
sudo dpkg -i vivid_0.8.0_amd64.deb
```
### run gogh to generate colorscheme
```bash
bash -c "$(wget -qO- https://git.io/vQgMr)"
```
### install and symlink kitty
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/kitty
sudo ln -s ~/.local/kitty.app/bin/kitten /usr/local/bin/kitten
```
### starship
```bash
curl -sS https://starship.rs/install.sh | sh
```
### install and symlink fd and bat
```bash
sudo ln -s $(which fdfind) /usr/local/bin/fd
sudo ln -s $(which batcat) /usr/local/bin/bat
```
### clone dotfiles and configs
```bash
mkdir ~/repos
git clone http://github.com/popshia/dotfiles ~/repos/dotfiles
git clone http://github.com/popshia/nvim ~/.config/nvim
```
### nerdfont
```bash
curl -fsSL https://raw.githubusercontent.com/ronniedroid/getnf/master/install.sh | bash
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
fisher install PatrickF1/fzf.fish jhillyerd/plugin-git jethrokuan/z jorgebucaran/autopair.fish nickeb96/puffer-fish
```