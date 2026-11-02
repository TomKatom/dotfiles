ZSH_CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
ZSH_STATE_DIR=${XDG_STATE_HOME:-$HOME/.local/state}/zsh
for dir in $ZSH_CACHE_DIR $ZSH_STATE_DIR; do
    [[ -d $dir ]] || mkdir -p $dir
done

# Order matters: plugins.zsh must come last (syntax highlighting wraps all widgets).
for module in options history completion keybinds tools aliases plugins; do
    source $ZDOTDIR/modules/$module.zsh
done
unset dir module
