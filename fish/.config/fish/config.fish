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

# os specific configs
switch (uname)
    case Darwin
        eval "$(/opt/homebrew/bin/brew shellenv)"
        if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
            eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
        else
            if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
                . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
            else
                set -x PATH /opt/homebrew/Caskroom/miniconda/base/bin $PATH
            end
        end
    case Linux
        set -gx LC_ALL C.UTF-8
        set -gx LANG C.UTF-8
        set -gx SUDO_EDITOR $EDITOR
        set -gx GTK_IM_MODULE fcitx
        set -gx QT_IM_MODULE fcitx
        set -gx XMODIFIERS @im fcitx
        fish_add_path ~/.local/bin
end
