# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
export PATH="$HOME/.local/bin:$PATH"

# Catppuccin Macchiato: blue user@host, mauve cwd, green/red prompt on success/failure
PROMPT='%F{#8aadf4}%n@%m%f %F{#c6a0f6}%~%f
%(?.%F{#a6da95}.%F{#ed8796})❯%f '
