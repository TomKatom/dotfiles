require('nvim-treesitter').install({
    'bash', 'c', 'cmake', 'cpp', 'css', 'diff', 'dockerfile', 'doxygen',
    'git_config', 'git_rebase', 'gitcommit', 'gitignore', 'hyprlang', 'ini',
    'json', 'kitty', 'lua', 'luadoc', 'make', 'markdown', 'markdown_inline',
    'python', 'query', 'regex', 'ssh_config', 'toml', 'vim', 'vimdoc', 'yaml', 'zsh',
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})
