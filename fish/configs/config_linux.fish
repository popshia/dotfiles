if status --is-interactive
    set -g fish_greeting
    fish_vi_key_bindings

    starship init fish | source
	zoxide init fish | source
	fzf_configure_bindings --history=\cr --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp

    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8
    export BAT_THEME="ansi"
    export LS_COLORS=(vivid generate gruvbox-dark)
end

set fzf_preview_dir_cmd eza --grid --icons $argv
set fzf_directory_opts --bind "ctrl-o:execute(nvim {} &> /dev/tty)"
set -g -x STARSHIP_CONFIG ~/.config/starship/starship.toml

alias cp '$HOME/repos/advcpmv/advcp -g'
alias mv '$HOME/repos/advcpmv/advmv -g'
