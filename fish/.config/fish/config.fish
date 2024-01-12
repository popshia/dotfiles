# remove fish_greeting
set -g fish_greeting

# source packages
starship init fish | source
zoxide init fish | source

# keybindings
fish_vi_key_bindings
fzf_configure_bindings --history=\cr --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp

# fzf.fish
set fzf_preview_dir_cmd eza --grid --icons $argv
set fzf_directory_opts --bind "L:execute(nvim {} &> /dev/tty)"

# set variables
set -gx LC_ALL C.UTF-8
set -gx LANG C.UTF-8
set -gx BAT_THEME "ansi"
set -gx LS_COLORS (vivid generate gruvbox-dark)
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

# path variables
fish_add_path ~/.local/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniconda3/bin/conda
	eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
	if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
		. "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
	else
		set -x PATH "$HOME/miniconda3/bin" $PATH
	end
end
# <<< conda initialize <<<
