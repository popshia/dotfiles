if status --is-interactive
    set -g fish_greeting
    fish_vi_key_bindings

    starship init fish | source

    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8
    export BAT_THEME="ansi"
    export LS_COLORS=(vivid generate gruvbox-dark)
end

set -g -x STARSHIP_CONFIG ~/.config/starship/starship.toml

xmodmap -e "keycode 64 = Mode_switch" # set Alt_l as the "Mode_switch"
xmodmap -e "keycode 43 = h H Left H" # h
xmodmap -e "keycode 44 = j J Down J" # j
xmodmap -e "keycode 45 = k K Up K" # k
xmodmap -e "keycode 46 = l L Right L" # l
