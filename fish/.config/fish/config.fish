if status --is-interactive
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
	set -gx EDITOR "nvim"
	set -gx VISUAL "nvim"
	set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
end
