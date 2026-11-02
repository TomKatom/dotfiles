export ZDOTDIR="$HOME/.config/zsh"

typeset -U path
path=("$HOME/.local/bin" $path)

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-R -F -i'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT='-c'
