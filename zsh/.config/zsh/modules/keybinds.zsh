bindkey -e

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

typeset -A keys=(
    kcuu1 up-line-or-beginning-search
    kcud1 down-line-or-beginning-search
    khome beginning-of-line
    kend  end-of-line
    kdch1 delete-char
    kDC5  kill-word
    kLFT5 backward-word
    kRIT5 forward-word
    kcbt  reverse-menu-complete
)
for cap widget in ${(kv)keys}; do
    [[ -n $terminfo[$cap] ]] && bindkey $terminfo[$cap] $widget
done
[[ -n $terminfo[kcbt] ]] && bindkey -M menuselect $terminfo[kcbt] reverse-menu-complete
unset keys cap widget

# Ctrl+Backspace sends ^H, unless the terminal uses ^H for plain Backspace.
[[ $terminfo[kbs] == $'\b' ]] || bindkey '^H' backward-kill-word

bindkey '^X^E' edit-command-line

# terminfo key capabilities only match while the terminal is in application mode.
if (( $+terminfo[smkx] && $+terminfo[rmkx] )); then
    autoload -Uz add-zle-hook-widget
    _keypad_on()  { echoti smkx }
    _keypad_off() { echoti rmkx }
    add-zle-hook-widget line-init _keypad_on
    add-zle-hook-widget line-finish _keypad_off
fi
