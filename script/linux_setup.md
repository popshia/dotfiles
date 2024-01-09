## Admin (sudo)

> install apt and essential packages
```bash
apt-add-repository ppa:fish-shell/release-3 -y
apt update && apt upgrade -y
apt install nala
nala install fish ripgrep htop fd-find batcat trash-cli kitty-terminfo
```
> install neovim with snap
```bash
snap install nvim --classic
```
## User (ai)

> switch user back to `ai`
```bash
su ai
```
> install and symlink `kitty`
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/kitty
ln -s ~/.local/kitty.app/bin/kitten /usr/local/bin/kitten
```
> install and symlink `fdfind` and `batcat`
```bash
ln -s $(which fdfind) ~/.local/bin/fd
ln -s $(which batcat) ~/.local/bin/bat
```
> clone dotfiles and configs
```bash
mkdir ~/repos
git clone http://github.com/popshia/dotfiles ~/repos/dotfiles
git clone http://github.com/popshia/nvim ~/.config/nvim
```
> intstall fzf
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
> install miniconda
```bash
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init fish
```
> change login shell and install fisher plugins
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
