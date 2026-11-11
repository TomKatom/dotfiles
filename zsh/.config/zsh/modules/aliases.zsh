alias ls='eza --group-directories-first --icons=auto'
alias ll='ls -l --git'
alias la='ll -a'
alias lt='ls --tree --level=2'

alias cat='bat -pp'
alias du='dust'
alias df='duf'

alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Copies kitty's terminfo and shell integration to the host, so remote apps don't break on xterm-kitty.
[[ $TERM == xterm-kitty ]] && alias ssh='kitten ssh'
