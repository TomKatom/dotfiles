local o = vim.opt

o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true
o.wrap = false
o.scrolloff = 8
o.sidescrolloff = 8
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.showmode = false
o.winborder = 'rounded'
o.pumheight = 10

o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4

o.ignorecase = true
o.smartcase = true
o.inccommand = 'split'

o.splitright = true
o.splitbelow = true
o.undofile = true
o.confirm = true
o.updatetime = 250
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
o.foldlevelstart = 99

-- LSP buffers prepend their omnifunc ("o") in lsp.lua.
o.autocomplete = true
o.complete = { '.^5', 'w^5', 'b^5' }
o.completeopt = { 'menuone', 'noselect', 'popup', 'fuzzy' }

-- Deferred: clipboard provider detection is the slowest part of startup.
vim.schedule(function()
    o.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
})
