# Linux System Setup
- __Description:__ set up linux environment
- __Author:__ Noah Lin
- __Contact:__ noah@c-link.com.tw
- __Date:__ 2024-01-09

# Table of Contents
  * [apt and essential packages](#apt-and-essential-packages)
  * [install eza](#install-eza)
  * [install zoxide](#install-zoxide)
  * [install neovim with snap](#install-neovim-with-snap)
  * [install vivid](#install-vivid)
  * [run gogh to generate colorscheme](#run-gogh-to-generate-colorscheme)
  * [install input-remapper](#install-input-remapper)
  * [install and symlink kitty](#install-and-symlink-kitty)
  * [starship](#starship)
  * [install and symlink fd and bat](#install-and-symlink-fd-and-bat)
  * [clone dotfiles and configs](#clone-dotfiles-and-configs)
  * [clone and build advcpmv](#clone-and-build-advcpmv)
  * [nerdfont](#nerdfont)
  * [fzf](#fzf)
  * [miniconda](#miniconda)
  * [change login shell and install fisher plugins](#change-login-shell-and-install-fisher-plugins)
  * [setup github-cli](#setup-github-cli)

### apt and essential packages
```bash
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update && apt upgrade -y
sudo apt install nala
sudo nala install -y fish ripgrep htop fd-find bat trash-cli kitty-terminfo ranger curl stow gpg gnome-tweaks gnome-shell-extension-manager npm
```
### install eza
```bash
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo nala update && sudo nala install -y eza
```
### install zoxide
```bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```
### build neovim
```bash
sudo apt install ninja-build gettext cmake unzip curl
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
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
### install input-remapper
```bash
sudo apt install git python3-setuptools gettext
git clone https://github.com/sezanzeb/input-remapper.git
cd input-remapper && ./scripts/build.sh
sudo apt install -y -f ./dist/input-remapper-2.0.1.deb
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
### clone and build advcpmv
```bash
curl https://raw.githubusercontent.com/jarun/advcpmv/master/install.sh --create-dirs -o ./advcpmv/install.sh && (cd advcpmv && sh install.sh)
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
conda config --set changeps1 False
# ~/miniconda3/bin/conda init fish (init in config.fish)
```
### change login shell and install fisher plugins
```bash
chsh -s /usr/bin/fish
fish
stow --target=$HOME fish starship ranger kitty
fisher update
```
### setup github-cli
```bash
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && sudo nala update && sudo nala install gh -y
```
