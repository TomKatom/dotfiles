# Cache each tool's generated init script so startup doesn't fork it;
# regenerate when the binary is newer (i.e. after an upgrade).
_cached_source() {
    local bin=$commands[$1] cache=$ZSH_CACHE_DIR/$1.zsh
    [[ -n $bin ]] || return
    [[ $cache -nt $bin ]] || "$@" >| $cache
    source $cache
}
_cached_source starship init zsh --print-full-init
_cached_source zoxide init zsh
_cached_source fzf --zsh
unfunction _cached_source

_fzf_fd_opts='--hidden --exclude .git'
export FZF_DEFAULT_COMMAND="fd --type f $_fzf_fd_opts"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND="fd --type d $_fzf_fd_opts"
_fzf_compgen_path() { fd ${=_fzf_fd_opts} . "$1" }
_fzf_compgen_dir() { fd --type d ${=_fzf_fd_opts} . "$1" }

# Colors: official Catppuccin Macchiato theme for fzf.
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border \
--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
--color=selected-bg:#494D64 \
--color=border:#6E738D,label:#CAD3F5"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:300 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always --icons=always {}'"
