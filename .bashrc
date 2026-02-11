#  _________________
# [____ Exports ____]
export EDITOR=nvim
export PATH="/usr/lib/ccache/bin/:$PATH"
export PATH=$PATH:~/.cargo/bin/
export PATH=~/.npm.global/bin:$PATH

#  _________________________
# [____ general aliases ____]
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias ts='~/.config/ml4w/scripts/snapshot.sh'
alias wifi='nmtui'
alias cleanup='~/.config/ml4w/scripts/cleanup.sh'

#  ------------------------
# [____ CUSTOMIZATION _____]
POSH=agnoster

# Prompt
# eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/zen.toml)"
# eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/EDM115-newline.omp.json)"
eval "$(oh-my-posh init bash --config ../ohmyposh/EDM115-newline.omp.json)"

#  -------------------
# [____ AUTOSTART ____]

# Fastfetch
if [[ $(tty) == *"pts"* ]]; then
    fastfetch --config examples/13
else
    echo
    if [ -f /bin/hyprctl ]; then
        echo "Start Hyprland with command Hyprland"
    fi
fi
