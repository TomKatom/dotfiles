zmodload zsh/complist
autoload -Uz compinit

# Run the slow security check + dump rebuild at most once a day; otherwise trust the dump.
() {
    local dump=$ZSH_CACHE_DIR/zcompdump
    if [[ ! -s $dump || -n $dump(#qN.mh+24) ]]; then
        compinit -d $dump
        touch $dump
    else
        compinit -C -d $dump
    fi
    [[ $dump.zwc -nt $dump ]] || zcompile $dump
}

setopt complete_in_word always_to_end

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR/compcache
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:descriptions' format '%F{#c6a0f6}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{#ed8796}-- no matches --%f'
