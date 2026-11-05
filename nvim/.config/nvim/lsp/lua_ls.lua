-- The only Lua here is Neovim and Hyprland config, so know both APIs everywhere.
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.git' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME, '/usr/share/hypr/stubs' },
            },
        },
    },
}
