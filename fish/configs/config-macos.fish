if status --is-interactive
    set -g fish_greeting
    fish_vi_key_bindings
    starship init fish | source
    fzf_configure_bindings --history=\cr --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp
    export BAT_THEME="gruvbox-dark"
    export LS_COLORS="$(vivid generate gruvbox-dark)"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
        eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
    end
    # <<< conda initialize <<<
end

alias cp '/usr/local/bin/advcp -g'
alias mv '/usr/local/bin/advmv -g'

# fzf configurations
set fzf_preview_dir_cmd eza --grid --icons $argv
set fzf_preview_file_cmd preview
set fzf_directory_opts --bind "ctrl-o:execute(nvim {} &> /dev/tty)"

export PATH="$PATH:$HOME/.local/bin"
set -Ux STARSHIP_CONFIG ~/.config/starship/starship.toml
