# remove fish_greeting
set -g fish_greeting

# source packages
starship init fish | source
zoxide init fish | source

# fzf keybindings
fish_vi_key_bindings
fzf_configure_bindings --history=\cr --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp

# fzf configurations
set fzf_preview_dir_cmd eza --grid --icons $argv
set fzf_directory_opts --bind "L:execute(nvim {} &> /dev/tty)"

# set variables
set -gx BAT_THEME "ansi"
set -gx LS_COLORS (vivid generate gruvbox-dark)
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
switch (uname)
	case Darwin
		if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
			eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
		else
			if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
				. "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
			else
				set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
			end
		end
	case Linux
		if test -f $HOME/miniconda3/bin/conda
			eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
		else
			if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
				. "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
			else
				set -x PATH "$HOME/miniconda3/bin" $PATH
			end
		end

		# other linux specific settings
		set -gx LC_ALL C.UTF-8
		set -gx LANG C.UTF-8
		set -gx SUDO_EDITOR $EDITOR
		fish_add_path ~/.local/bin
end
# <<< conda initialize <<<
