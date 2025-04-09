# remove fish_greeting
set -g fish_greeting

# source packages
starship init fish | source
zoxide init fish | source

# fzf keybindings
fish_vi_key_bindings
fzf_configure_bindings --history=\cr --directory=\cf --git_log=\cg --git_status=\cs --processes=

# fzf configurations
set fzf_preview_dir_cmd eza --grid --icons $argv
set fzf_directory_opts --bind "ctrl-o:execute(nvim {} &> /dev/tty)"

# set variables
set -gx BAT_THEME ansi
set -gx LS_COLORS (vivid generate gruvbox-dark)
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
abbr -a vim nvim

# os specific configs
switch (uname)
    case Darwin
        # Added by OrbStack: command-line tools and integration
        # This won't be added again if you remove it.
        source ~/.orbstack/shell/init2.fish 2>/dev/null || :
    case Linux
        set -gx LC_ALL C.UTF-8
        set -gx LANG C.UTF-8
        set -gx SUDO_EDITOR $EDITOR
        set -gx GTK_IM_MODULE fcitx
        set -gx QT_IM_MODULE fcitx
        set -gx XMODIFIERS @im fcitx
        fish_add_path ~/.local/bin
end

if status --is-interactive
    pokemon-colorscripts -r
end
