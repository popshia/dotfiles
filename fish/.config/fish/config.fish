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

# set abbreviations
abbr -a vim nvim
abbr -a lg lazygit
abbr -a lr 'defaults write com.apple.dock ResetLaunchPad -bool true && killall Dock'

# os specific configs
switch (uname)
    case Darwin
        # Added by OrbStack: command-line tools and integration
        # This won't be added again if you remove it.
        source ~/.orbstack/shell/init2.fish 2>/dev/null || :

        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
            eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
        else
            if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
                . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
            else
                set -x PATH /opt/homebrew/Caskroom/miniconda/base/bin $PATH
            end
        end
        # <<< conda initialize <<<

        # pnpm
        set -gx PNPM_HOME $HOME/Library/pnpm
        if not string match -q -- $PNPM_HOME $PATH
            set -gx PATH "$PNPM_HOME" $PATH
        end
        # pnpm end
    case Linux
        set -gx LC_ALL C.UTF-8
        set -gx LANG C.UTF-8
        set -gx SUDO_EDITOR $EDITOR
        set -gx GTK_IM_MODULE fcitx
        set -gx QT_IM_MODULE fcitx
        set -gx XMODIFIERS @im fcitx
        fish_add_path ~/.local/bin
end
